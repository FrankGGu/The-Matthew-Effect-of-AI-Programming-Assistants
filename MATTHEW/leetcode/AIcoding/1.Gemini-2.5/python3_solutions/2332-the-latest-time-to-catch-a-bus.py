class Solution:
    def latestTimeCatchTheBus(self, buses: list[int], passengers: list[int], capacity: int) -> int:
        passengers_set = set(passengers)

        p_ptr = 0
        result_time = -1

        # Iterate through each bus
        for i in range(len(buses)):
            bus_time = buses[i]
            current_bus_capacity_used = 0
            last_passenger_on_this_bus = -1 # Stores the arrival time of the last passenger who boarded this bus

            # Fill the current bus with eligible passengers
            # Passengers must arrive at or before bus_time, and there must be capacity
            while p_ptr < len(passengers) and passengers[p_ptr] <= bus_time and current_bus_capacity_used < capacity:
                current_bus_capacity_used += 1
                last_passenger_on_this_bus = passengers[p_ptr]
                p_ptr += 1

            # If this is the last bus, determine the latest possible arrival time for the new passenger
            if i == len(buses) - 1:
                if current_bus_capacity_used < capacity:
                    # The last bus is not full. The new passenger can potentially arrive at bus_time.
                    # We need to find the largest time 't' such that t <= bus_time and t is not an existing passenger's arrival time.
                    result_time = bus_time
                    while result_time in passengers_set:
                        result_time -= 1
                else:
                    # The last bus is full. The new passenger must have arrived before the last passenger who boarded this bus.
                    # We need to find the largest time 't' such that t <= last_passenger_on_this_bus - 1 and t is not an existing passenger's arrival time.
                    result_time = last_passenger_on_this_bus - 1
                    while result_time in passengers_set:
                        result_time -= 1

        return result_time