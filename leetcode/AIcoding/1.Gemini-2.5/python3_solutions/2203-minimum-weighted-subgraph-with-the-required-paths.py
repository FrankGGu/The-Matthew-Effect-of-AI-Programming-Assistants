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
            distances = [math.inf] * n
            distances[start_node] = 0
            pq = [(0, start_node)]

            while pq:
                d, u = heapq.heappop(pq)

                if d > distances[u]:
                    continue

                for v, weight in graph[u]:
                    if distances[u] + weight < distances[v]:
                        distances[v] = distances[u] + weight
                        heapq.heappush(pq, (distances[v], v))
            return distances

        dist_src1 = dijkstra(src1, adj)
        dist_src2 = dijkstra(src2, adj)
        dist_dest_rev = dijkstra(dest, rev_adj)

        min_total_weight = math.inf

        for i in range(n):
            if dist_src1[i] != math.inf and dist_src2[i] != math.inf and dist_dest_rev[i] != math.inf:
                min_total_weight = min(min_total_weight, dist_src1[i] + dist_src2[i] + dist_dest_rev[i])

        return -1 if min_total_weight == math.inf else min_total_weight