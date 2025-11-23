class Solution:
    def latestTimeToCatchTheBus(self, buses: List[int], passengers: List[int], capacity: int) -> int:
        buses.sort()
        passengers.sort()

        p_idx = 0
        for bus in buses:
            count = 0
            while p_idx < len(passengers) and passengers[p_idx] <= bus and count < capacity:
                p_idx += 1
                count += 1

        last_passenger_time = passengers[p_idx - 1] if p_idx > 0 and passengers[p_idx - 1] <= bus else bus

        if count < capacity:
            return bus

        while last_passenger_time in passengers:
            last_passenger_time -= 1

        return last_passenger_time