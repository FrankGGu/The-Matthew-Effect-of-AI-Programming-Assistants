import heapq

class Solution:
    def minRefuelStops(self, target: int, startFuel: int, stations: list[list[int]]) -> int:
        stations.append([target, 0])
        pq = []
        ans = 0
        prev = 0
        fuel = startFuel

        for location, capacity in stations:
            fuel -= (location - prev)
            while pq and fuel < 0:
                fuel += -heapq.heappop(pq)
                ans += 1
            if fuel < 0:
                return -1
            heapq.heappush(pq, -capacity)
            prev = location

        return ans