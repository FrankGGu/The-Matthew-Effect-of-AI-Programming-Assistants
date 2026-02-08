import heapq

class Solution:
    def countPaths(self, n: int, roads: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]
        for u, v, w in roads:
            graph[u].append((v, w))
            graph[v].append((u, w))

        dist = [float('inf')] * n
        ways = [0] * n
        dist[0] = 0
        ways[0] = 1
        pq = [(0, 0)]

        while pq:
            d, u = heapq.heappop(pq)

            if d > dist[u]:
                continue

            for v, w in graph[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    ways[v] = ways[u]
                    heapq.heappush(pq, (dist[v], v))
                elif dist[v] == dist[u] + w:
                    ways[v] = (ways[v] + ways[u]) % (10**9 + 7)

        return ways[n - 1] % (10**9 + 7)