from typing import List
import heapq

class Solution:
    def shortestDistance(self, n: int, queries: List[str]) -> List[int]:
        graph = [[] for _ in range(n)]
        for q in queries:
            u, v = map(int, q.split())
            graph[u].append(v)

        dist = [float('inf')] * n
        dist[0] = 0
        heap = [(0, 0)]

        while heap:
            d, u = heapq.heappop(heap)
            if d > dist[u]:
                continue
            for v in graph[u]:
                if dist[v] > d + 1:
                    dist[v] = d + 1
                    heapq.heappush(heap, (dist[v], v))

        return dist