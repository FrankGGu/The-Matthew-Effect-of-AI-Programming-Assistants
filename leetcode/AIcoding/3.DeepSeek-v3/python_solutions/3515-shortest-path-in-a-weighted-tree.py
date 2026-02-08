import heapq
from collections import defaultdict

class Solution:
    def shortestPath(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[int]:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start):
            dist = {node: float('inf') for node in range(1, n+1)}
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

        res = []
        for u, v in queries:
            dist = dijkstra(u)
            res.append(dist[v])
        return res