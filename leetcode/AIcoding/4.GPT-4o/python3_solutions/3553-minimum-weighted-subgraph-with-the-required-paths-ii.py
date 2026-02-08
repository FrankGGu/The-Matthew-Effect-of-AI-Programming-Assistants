import heapq
from collections import defaultdict

class Solution:
    def minimumWeight(self, n: int, edges: List[List[int]], src1: int, src2: int, dest: int) -> int:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))

        def dijkstra(source):
            dist = [float('inf')] * n
            dist[source] = 0
            heap = [(0, source)]
            while heap:
                d, node = heapq.heappop(heap)
                if d > dist[node]:
                    continue
                for neighbor, weight in graph[node]:
                    if dist[node] + weight < dist[neighbor]:
                        dist[neighbor] = dist[node] + weight
                        heapq.heappush(heap, (dist[neighbor], neighbor))
            return dist

        dist_from_src1 = dijkstra(src1)
        dist_from_src2 = dijkstra(src2)
        dist_from_dest = dijkstra(dest)

        min_weight = float('inf')
        for i in range(n):
            if dist_from_src1[i] < float('inf') and dist_from_src2[i] < float('inf') and dist_from_dest[i] < float('inf'):
                min_weight = min(min_weight, dist_from_src1[i] + dist_from_src2[i] + dist_from_dest[i])

        return min_weight if min_weight < float('inf') else -1