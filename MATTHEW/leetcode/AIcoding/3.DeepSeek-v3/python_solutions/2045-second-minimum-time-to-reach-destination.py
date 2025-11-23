import heapq
from collections import deque

class Solution:
    def secondMinimum(self, n: int, edges: List[List[int]], time: int, change: int) -> int:
        graph = [[] for _ in range(n + 1)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dist = [[float('inf')] * 2 for _ in range(n + 1)]
        dist[1][0] = 0
        heap = []
        heapq.heappush(heap, (0, 1))

        while heap:
            current_time, node = heapq.heappop(heap)
            if current_time > dist[node][1]:
                continue
            for neighbor in graph[node]:
                if (current_time // change) % 2 == 1:
                    next_time = (current_time // change + 1) * change + time
                else:
                    next_time = current_time + time
                if next_time < dist[neighbor][0]:
                    dist[neighbor][1] = dist[neighbor][0]
                    dist[neighbor][0] = next_time
                    heapq.heappush(heap, (dist[neighbor][0], neighbor))
                    heapq.heappush(heap, (dist[neighbor][1], neighbor))
                elif dist[neighbor][0] < next_time < dist[neighbor][1]:
                    dist[neighbor][1] = next_time
                    heapq.heappush(heap, (dist[neighbor][1], neighbor))

        return dist[n][1]