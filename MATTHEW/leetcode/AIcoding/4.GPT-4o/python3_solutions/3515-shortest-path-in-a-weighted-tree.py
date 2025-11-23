import heapq
from collections import defaultdict

class Solution:
    def shortestPath(self, n: int, edges: List[List[int]], start: int, end: int) -> int:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        min_heap = [(0, start)]
        distances = {i: float('inf') for i in range(n)}
        distances[start] = 0

        while min_heap:
            curr_dist, node = heapq.heappop(min_heap)

            if node == end:
                return curr_dist

            for neighbor, weight in graph[node]:
                distance = curr_dist + weight
                if distance < distances[neighbor]:
                    distances[neighbor] = distance
                    heapq.heappush(min_heap, (distance, neighbor))

        return -1