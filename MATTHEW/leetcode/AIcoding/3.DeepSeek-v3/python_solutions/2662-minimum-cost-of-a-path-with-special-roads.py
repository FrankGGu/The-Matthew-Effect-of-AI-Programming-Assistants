import heapq

class Solution:
    def minimumCost(self, start: List[int], target: List[int], specialRoads: List[List[int]]) -> int:
        x1, y1 = start
        x2, y2 = target
        heap = []
        heapq.heappush(heap, (0, x1, y1))
        visited = set()
        visited.add((x1, y1))

        while heap:
            cost, x, y = heapq.heappop(heap)
            if x == x2 and y == y2:
                return cost
            # Option 1: Go directly to target
            direct_cost = cost + abs(x - x2) + abs(y - y2)
            heapq.heappush(heap, (direct_cost, x2, y2))

            # Option 2: Use any special road
            for road in specialRoads:
                a, b, c, d, road_cost = road
                new_cost = cost + abs(x - a) + abs(y - b) + road_cost
                if (c, d) not in visited or new_cost < cost + abs(x - c) + abs(y - d):
                    heapq.heappush(heap, (new_cost, c, d))
                    visited.add((c, d))

        return -1