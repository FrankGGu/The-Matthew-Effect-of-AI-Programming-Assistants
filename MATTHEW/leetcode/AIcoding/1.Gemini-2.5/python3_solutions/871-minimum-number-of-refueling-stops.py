import heapq

class Solution:
    def minRefuelStops(self, target: int, start_fuel: int, stations: list[list[int]]) -> int:
        stops = 0
        current_fuel = start_fuel
        pq = []
        prev_pos = 0

        stations.append([target, 0])

        for pos, fuel in stations:
            current_fuel -= (pos - prev_pos)
            prev_pos = pos

            while current_fuel < 0:
                if not pq:
                    return -1

                max_fuel_available = -heapq.heappop(pq)
                current_fuel += max_fuel_available
                stops += 1

            heapq.heappush(pq, -fuel)

        return stops