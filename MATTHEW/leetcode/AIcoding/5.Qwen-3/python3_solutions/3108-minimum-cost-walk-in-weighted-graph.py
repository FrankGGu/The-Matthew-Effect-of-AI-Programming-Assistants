from typing import List
import heapq

class Solution:
    def minCost(self, n: int, edges: List[List[int]], start: int, end: int, k: int) -> int:
        graph = [[] for _ in range(n)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        dist = [[float('inf')] * (k + 1) for _ in range(n)]
        heap = [(0, start, 0)]
        dist[start][0] = 0

        while heap:
            cost, node, skips = heapq.heappop(heap)
            if node == end:
                return cost
            if cost > dist[node][skips]:
                continue
            for neighbor, weight in graph[node]:
                if dist[neighbor][skips] > cost + weight:
                    dist[neighbor][skips] = cost + weight
                    heapq.heappush(heap, (dist[neighbor][skips], neighbor, skips))
                if skips < k and dist[neighbor][skips + 1] > cost:
                    dist[neighbor][skips + 1] = cost
                    heapq.heappush(heap, (dist[neighbor][skips + 1], neighbor, skips + 1))

        return -1