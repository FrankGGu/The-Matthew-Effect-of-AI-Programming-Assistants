import heapq

class Solution:
    def countPaths(self, n: int, roads: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v, time in roads:
            adj[u].append((v, time))
            adj[v].append((u, time))

        dist = [float('inf')] * n
        ways = [0] * n

        dist[0] = 0
        ways[0] = 1

        min_heap = [(0, 0)]  # (current_time, node)

        MOD = 10**9 + 7

        while min_heap:
            current_time, u = heapq.heappop(min_heap)

            if current_time > dist[u]:
                continue

            for v, travel_time in adj[u]:
                if dist[u] + travel_time < dist[v]:
                    dist[v] = dist[u] + travel_time
                    ways[v] = ways[u]
                    heapq.heappush(min_heap, (dist[v], v))
                elif dist[u] + travel_time == dist[v]:
                    ways[v] = (ways[v] + ways[u]) % MOD

        return ways[n - 1]