import heapq

class Solution:
    def minRefuelStops(self, target: int, startFuel: int, stations: List[List[int]]) -> int:
        max_heap = []
        stations.append([target, 0])
        res = 0
        prev = 0
        tank = startFuel

        for pos, fuel in stations:
            tank -= (pos - prev)
            while tank < 0 and max_heap:
                tank += -heapq.heappop(max_heap)
                res += 1
            if tank < 0:
                return -1
            heapq.heappush(max_heap, -fuel)
            prev = pos

        return res