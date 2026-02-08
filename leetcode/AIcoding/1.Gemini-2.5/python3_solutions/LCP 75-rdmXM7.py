import heapq
from typing import List

class Solution:
    def solve(self, n: int, teleports: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]

        for i in range(n - 1):
            graph[i].append((i + 1, 1))

        for u, v, w in teleports:
            graph[u].append((v, w))

        start_node = 0
        end_node = n - 1

        distances = [float('inf')] * n
        distances[start_node] = 0

        pq = [(0, start_node)]

        while pq:
            current_cost, u = heapq.heappop(pq)

            if current_cost > distances[u]:
                continue

            for v, weight in graph[u]:
                if distances[u] + weight < distances[v]:
                    distances[v] = distances[u] + weight
                    heapq.heappush(pq, (distances[v], v))

        return distances[end_node] if distances[end_node] != float('inf') else -1