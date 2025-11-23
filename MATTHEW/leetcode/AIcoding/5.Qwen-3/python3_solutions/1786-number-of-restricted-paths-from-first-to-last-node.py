from typing import List
import heapq

class Solution:
    def countRestrictedPaths(self, graph: List[List[int]], n: int, m: int) -> int:
        adj = [[] for _ in range(n + 1)]
        for u, v, w in graph:
            adj[u].append((v, w))
            adj[v].append((u, w))

        dist = [float('inf')] * (n + 1)
        dist[1] = 0
        heap = [(0, 1)]

        while heap:
            d, u = heapq.heappop(heap)
            if d > dist[u]:
                continue
            for v, w in adj[u]:
                if dist[v] > d + w:
                    dist[v] = d + w
                    heapq.heappush(heap, (dist[v], v))

        nodes = sorted([(dist[i], i) for i in range(1, n + 1)], key=lambda x: x[0])

        dp = [0] * (n + 1)
        dp[n] = 1

        for d, u in nodes:
            for v, _ in adj[u]:
                if dist[v] > dist[u]:
                    dp[v] += dp[u]

        return dp[n]