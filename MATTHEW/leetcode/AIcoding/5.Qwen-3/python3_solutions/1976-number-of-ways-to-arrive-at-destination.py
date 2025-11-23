from typing import List
import heapq

class Solution:
    def countPathsToDestination(self, n: int, roads: List[List[int]]) -> int:
        MOD = 10**9 + 7
        graph = [[] for _ in range(n)]
        for u, v, _ in roads:
            graph[u].append(v)
            graph[v].append(u)

        dist = [float('inf')] * n
        count = [0] * n
        dist[0] = 0
        count[0] = 1

        heap = [(0, 0)]

        while heap:
            d, u = heapq.heappop(heap)
            if d > dist[u]:
                continue
            for v in graph[u]:
                if dist[v] > d + 1:
                    dist[v] = d + 1
                    count[v] = count[u]
                    heapq.heappush(heap, (dist[v], v))
                elif dist[v] == d + 1:
                    count[v] = (count[v] + count[u]) % MOD

        return count[n-1]