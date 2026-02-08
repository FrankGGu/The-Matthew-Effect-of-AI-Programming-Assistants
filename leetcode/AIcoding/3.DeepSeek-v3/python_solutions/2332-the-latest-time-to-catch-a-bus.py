class Solution:
    def latestTimeCatchTheBus(self, buses: List[int], passengers: List[int], capacity: int) -> int:
        buses.sort()
        passengers.sort()

        j = 0
        latest_time = 0

        for bus in buses:
            current_capacity = 0
            while j < len(passengers) and passengers[j] <= bus and current_capacity < capacity:
                if j == 0 or passengers[j] - 1 != passengers[j - 1]:
                    latest_time = passengers[j] - 1
                current_capacity += 1
                j += 1

            if current_capacity < capacity and (j == 0 or passengers[j - 1] != bus):
                latest_time = bus

        return latest_time