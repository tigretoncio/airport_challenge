require_relative "error_mgr"
require_relative "weather"
class Airport
  include ErrorManager
  include Weather

  DEFAULT_CAPACITY = 20

  attr_reader :planes, :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @planes = []
    @capacity = capacity
  end

  def takeoff(plane)
    check_errors(plane, false)
    plane.takeoff
    leave_airport(plane)
  end

  def land(plane)
    check_errors(plane, true)
    plane.land
    access_airport(plane)
  end

  private

    def in_airport?(plane)
      planes.include?(plane)
    end

    def access_airport(plane)
      planes << plane
    end

    def leave_airport(plane)
      planes.delete(plane)
    end

    def full?
      planes.count >= capacity
    end
end
