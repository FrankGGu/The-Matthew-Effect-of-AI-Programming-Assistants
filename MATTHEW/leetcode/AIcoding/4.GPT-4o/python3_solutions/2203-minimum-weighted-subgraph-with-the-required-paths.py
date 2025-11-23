import heapq
from collections import defaultdict

class Solution:
    def minimumWeight(self, n: int, edges: List[List[int]], src1: int, src2: int, dest: int) -> int:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            pq = [(0, start)]
            while pq:
                d, node = heapq.heappop(pq)
                if d > dist[node]:
                    continue
                for neighbor, weight in graph[node]:
                    if d + weight < dist[neighbor]:
                        dist[neighbor] = d + weight
                        heapq.heappush(pq, (dist[neighbor], neighbor))
            return dist

        dist_from_src1 = dijkstra(src1)
        dist_from_src2 = dijkstra(src2)
        dist_from_dest = dijkstra(dest)

        min_weight = float('inf')
        for i in range(n):
            if dist_from_src1[i] < float('inf') and dist_from_src2[i] < float('inf') and dist_from_dest[i] < float('inf'):
                min_weight = min(min_weight, dist_from_src1[i] + dist_from_src2[i] + dist_from_dest[i])

        return min_weight if min_weight < float('inf') else -1