import heapq
import math

class Solution:
    def minimumWeight(self, n: int, edges: list[list[int]], src1: int, src2: int, dest: int) -> int:
        adj = [[] for _ in range(n)]
        rev_adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            rev_adj[v].append((u, w))

        def dijkstra(start_node, graph):
            dist = [math.inf] * n
            dist[start_node] = 0
            pq = [(0, start_node)]

            while pq:
                d, u = heapq.heappop(pq)

                if d > dist[u]:
                    continue

                for v, weight in graph[u]:
                    if dist[u] + weight < dist[v]:
                        dist[v] = dist[u] + weight
                        heapq.heappush(pq, (dist[v], v))
            return dist

        dist_from_src1 = dijkstra(src1, adj)
        dist_from_src2 = dijkstra(src2, adj)
        dist_to_dest = dijkstra(dest, rev_adj)

        min_total_weight = math.inf
        for m in range(n):
            if dist_from_src1[m] != math.inf and \
               dist_from_src2[m] != math.inf and \
               dist_to_dest[m] != math.inf:

                current_total_weight = dist_from_src1[m] + dist_from_src2[m] + dist_to_dest[m]
                min_total_weight = min(min_total_weight, current_total_weight)

        if min_total_weight == math.inf:
            return -1
        else:
            return min_total_weight