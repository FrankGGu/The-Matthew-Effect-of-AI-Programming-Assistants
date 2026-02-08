from collections import defaultdict
import heapq

class Solution:
    def minTime(self, n: int, edges: List[List[int]], time: List[int]) -> int:
        graph = defaultdict(list)
        for u, v, t in edges:
            graph[u].append((v, t))
            graph[v].append((u, t))

        def dijkstra(start):
            dist = {i: float('inf') for i in range(n)}
            dist[start] = 0
            min_heap = [(0, start)]
            while min_heap:
                curr_time, node = heapq.heappop(min_heap)
                if curr_time > dist[node]:
                    continue
                for neighbor, travel_time in graph[node]:
                    new_time = curr_time + travel_time
                    if new_time < dist[neighbor]:
                        dist[neighbor] = new_time
                        heapq.heappush(min_heap, (new_time, neighbor))
            return dist

        total_time = 0
        for i in range(n):
            dist = dijkstra(i)
            total_time += min(dist[j] + time[j] for j in range(n) if dist[j] != float('inf'))

        return total_time