import heapq

class Solution:
    def minimumWeight(self, n: int, edges: List[List[int]], src1: int, src2: int, dest: int) -> int:
        graph = [[] for _ in range(n)]
        reverse_graph = [[] for _ in range(n)]
        for u, v, w in edges:
            graph[u].append((v, w))
            reverse_graph[v].append((u, w))

        def dijkstra(start, graph):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            visited = set()
            while heap:
                current_dist, u = heapq.heappop(heap)
                if u in visited:
                    continue
                visited.add(u)
                for v, w in graph[u]:
                    if dist[v] > current_dist + w:
                        dist[v] = current_dist + w
                        heapq.heappush(heap, (dist[v], v))
            return dist

        dist_src1 = dijkstra(src1, graph)
        dist_src2 = dijkstra(src2, graph)
        dist_dest = dijkstra(dest, reverse_graph)

        min_weight = float('inf')
        for i in range(n):
            total = dist_src1[i] + dist_src2[i] + dist_dest[i]
            if total < min_weight:
                min_weight = total

        return min_weight if min_weight != float('inf') else -1