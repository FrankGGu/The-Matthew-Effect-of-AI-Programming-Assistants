import heapq

class Solution:
    def findMinCost(self, logs: List[List[int]], n: int) -> int:
        graph = [[] for _ in range(n + 1)]
        for x, y, cost in logs:
            graph[x].append((y, cost))
            graph[y].append((x, cost))

        visited = [False] * (n + 1)
        min_heap = []
        heapq.heappush(min_heap, (0, 1))
        total_cost = 0

        while min_heap:
            cost, node = heapq.heappop(min_heap)
            if visited[node]:
                continue
            visited[node] = True
            total_cost += cost
            for neighbor, edge_cost in graph[node]:
                if not visited[neighbor]:
                    heapq.heappush(min_heap, (edge_cost, neighbor))

        return total_cost if all(visited[1:]) else -1