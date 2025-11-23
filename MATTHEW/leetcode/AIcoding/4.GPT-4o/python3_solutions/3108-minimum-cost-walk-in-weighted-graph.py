import heapq
from collections import defaultdict

class Solution:
    def minimumCost(self, n: int, connections: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v, cost in connections:
            graph[u].append((v, cost))
            graph[v].append((u, cost))

        min_heap = [(0, 1)]
        min_cost = {i: float('inf') for i in range(1, n + 1)}
        min_cost[1] = 0
        visited = set()

        while min_heap:
            cost, node = heapq.heappop(min_heap)
            if node in visited:
                continue
            visited.add(node)

            for neighbor, edge_cost in graph[node]:
                if neighbor not in visited and cost + edge_cost < min_cost[neighbor]:
                    min_cost[neighbor] = cost + edge_cost
                    heapq.heappush(min_heap, (min_cost[neighbor], neighbor))

        total_cost = sum(min_cost[i] for i in range(1, n + 1) if min_cost[i] != float('inf'))
        return total_cost if len(visited) == n else -1