import heapq

class Solution:
    def findTheCity(self, n: int, edges: list[list[int]], distanceThreshold: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            pq = [(0, start)]

            while pq:
                d, u = heapq.heappop(pq)
                if d > dist[u]:
                    continue
                for v, w in adj[u]:
                    if dist[u] + w < dist[v]:
                        dist[v] = dist[u] + w
                        heapq.heappush(pq, (dist[v], v))
            return dist

        min_reachable = float('inf')
        city = -1

        for i in range(n):
            distances = dijkstra(i)
            reachable_count = 0
            for d in distances:
                if d <= distanceThreshold:
                    reachable_count += 1

            if reachable_count <= min_reachable:
                min_reachable = reachable_count
                city = i

        return city