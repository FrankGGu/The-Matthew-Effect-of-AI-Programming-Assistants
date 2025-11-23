import heapq

class Solution:
    def minRefuelStops(self, target: int, startFuel: int, stations: List[List[int]]) -> int:
        max_heap = []
        stations.append([target, 0])
        curr_fuel = startFuel
        stops = 0
        prev_position = 0

        for position, fuel in stations:
            curr_fuel -= position - prev_position
            while max_heap and curr_fuel < 0:
                curr_fuel += -heapq.heappop(max_heap)
                stops += 1
            if curr_fuel < 0:
                return -1
            heapq.heappush(max_heap, -fuel)
            prev_position = position

        return stops