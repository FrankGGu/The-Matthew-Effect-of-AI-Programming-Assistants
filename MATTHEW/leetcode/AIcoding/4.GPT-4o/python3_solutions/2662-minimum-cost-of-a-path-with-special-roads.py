import heapq

class Solution:
    def minimumCost(self, start: List[int], target: List[int], specialRoads: List[List[int]]) -> int:
        def dijkstra(start):
            heap = [(0, start[0], start[1])]
            dist = {(start[0], start[1]): 0}
            while heap:
                cost, x, y = heapq.heappop(heap)
                if (x, y) == (target[0], target[1]):
                    return cost
                for nx, ny in [(target[0], target[1])] + [(sx, sy) for sx, sy, _, _, _ in specialRoads]:
                    new_cost = cost + abs(nx - x) + abs(ny - y)
                    if (nx, ny) not in dist or new_cost < dist[(nx, ny)]:
                        dist[(nx, ny)] = new_cost
                        heapq.heappush(heap, (new_cost, nx, ny))
                for sx, sy, ex, ey, sc in specialRoads:
                    new_cost = cost + sc + abs(sx - x) + abs(sy - y)
                    if (ex, ey) not in dist or new_cost < dist[(ex, ey)]:
                        dist[(ex, ey)] = new_cost
                        heapq.heappush(heap, (new_cost, ex, ey))

        return dijkstra(start)