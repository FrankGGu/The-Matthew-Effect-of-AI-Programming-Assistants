import collections
import heapq

class Solution:
    def networkDelayTime(self, times: list[list[int]], n: int, k: int) -> int:
        graph = collections.defaultdict(list)
        for u, v, w in times:
            graph[u].append((v, w))

        dist = {i: float('inf') for i in range(1, n + 1)}
        dist[k] = 0

        min_heap = [(0, k)]

        while min_heap:
            current_time, u = heapq.heappop(min_heap)

            if current_time > dist[u]:
                continue

            for v, travel_time in graph[u]:
                if dist[u] + travel_time < dist[v]:
                    dist[v] = dist[u] + travel_time
                    heapq.heappush(min_heap, (dist[v], v))

        max_delay = 0
        for i in range(1, n + 1):
            if dist[i] == float('inf'):
                return -1
            max_delay = max(max_delay, dist[i])

        return max_delay