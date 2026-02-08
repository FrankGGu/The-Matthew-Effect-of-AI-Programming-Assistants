import heapq
from typing import List

class Solution:
    def shortestPath(self, n: int, edges: List[List[int]], start_node: int) -> List[int]:
        adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        distances = [float('inf')] * n
        distances[start_node] = 0

        pq = [(0, start_node)]

        while pq:
            d, u = heapq.heappop(pq)

            if d > distances[u]:
                continue

            for v, weight in adj[u]:
                if distances[u] + weight < distances[v]:
                    distances[v] = distances[u] + weight
                    heapq.heappush(pq, (distances[v], v))

        return distances