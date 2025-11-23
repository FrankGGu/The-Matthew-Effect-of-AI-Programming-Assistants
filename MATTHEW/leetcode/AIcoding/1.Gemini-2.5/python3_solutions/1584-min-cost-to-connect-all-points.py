import heapq

class Solution:
    def minCostConnectPoints(self, points: list[list[int]]) -> int:
        n = len(points)

        min_cost = 0
        visited = [False] * n
        min_heap = [(0, 0)]  # (cost, point_index) - starting from point 0 with cost 0
        edges_count = 0

        while min_heap and edges_count < n:
            cost, u = heapq.heappop(min_heap)

            if visited[u]:
                continue

            visited[u] = True
            min_cost += cost
            edges_count += 1

            for v in range(n):
                if not visited[v]:
                    dist = abs(points[u][0] - points[v][0]) + abs(points[u][1] - points[v][1])
                    heapq.heappush(min_heap, (dist, v))

        return min_cost