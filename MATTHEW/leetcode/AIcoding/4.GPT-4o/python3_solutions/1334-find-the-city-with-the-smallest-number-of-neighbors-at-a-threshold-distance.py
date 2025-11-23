import heapq
from collections import defaultdict

class Solution:
    def findTheCity(self, n: int, edges: List[List[int]], distanceThreshold: int) -> int:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, node = heapq.heappop(heap)
                if d > dist[node]:
                    continue
                for neighbor, weight in graph[node]:
                    new_dist = d + weight
                    if new_dist < dist[neighbor]:
                        dist[neighbor] = new_dist
                        heapq.heappush(heap, (new_dist, neighbor))
            return dist

        min_neighbors = float('inf')
        city_with_min_neighbors = -1

        for i in range(n):
            distances = dijkstra(i)
            neighbors_count = sum(1 for d in distances if 0 < d <= distanceThreshold)
            if neighbors_count < min_neighbors or (neighbors_count == min_neighbors and i > city_with_min_neighbors):
                min_neighbors = neighbors_count
                city_with_min_neighbors = i

        return city_with_min_neighbors