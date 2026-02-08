import heapq

class Solution:
    def minimumCost(self, start: List[int], target: List[int], specialRoads: List[List[int]]) -> int:
        graph = defaultdict(list)
        graph[(start[0], start[1])] = []

        for road in specialRoads:
            x1, y1, x2, y2, cost = road
            graph[(x1, y1)].append(((x2, y2), cost))
            graph[(x1, y1)] = graph[(x1, y1)]

        visited = set()
        pq = [(0, (start[0], start[1]))]

        while pq:
            cost, node = heapq.heappop(pq)

            if node == (target[0], target[1]):
                return cost

            if node in visited:
                continue
            visited.add(node)

            x, y = node

            direct_cost = abs(target[0] - x) + abs(target[1] - y)

            if (target[0], target[1]) not in visited:
                heapq.heappush(pq, (cost + direct_cost, (target[0], target[1])))

            for neighbor, road_cost in graph[node]:
                new_cost = cost + road_cost
                if neighbor not in visited:
                    heapq.heappush(pq, (new_cost, neighbor))

            for road in specialRoads:
                x1, y1, x2, y2, road_cost = road
                if (x1, y1) == node and (x2, y2) not in visited:
                    new_cost = cost + road_cost
                    heapq.heappush(pq, (new_cost, (x2, y2)))

            for road in specialRoads:
                x1, y1, x2, y2, road_cost = road
                if (x1, y1) != node:
                    dist = abs(x1 - x) + abs(y1 - y)
                    if (x1, y1) not in visited:
                        heapq.heappush(pq, (cost + dist, (x1, y1)))

        x, y = start
        return abs(target[0] - x) + abs(target[1] - y)