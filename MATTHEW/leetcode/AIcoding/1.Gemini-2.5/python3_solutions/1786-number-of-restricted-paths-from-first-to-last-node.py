import heapq

class Solution:
    def countRestrictedPaths(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n + 1)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        dist = [float('inf')] * (n + 1)
        dist[n] = 0

        pq = [(0, n)] # (distance, node)

        while pq:
            d, u = heapq.heappop(pq)

            if d > dist[u]:
                continue

            for v, weight in adj[u]:
                if dist[u] + weight < dist[v]:
                    dist[v] = dist[u] + weight
                    heapq.heappush(pq, (dist[v], v))

        MOD = 10**9 + 7

        dp = [0] * (n + 1)
        dp[n] = 1

        nodes_sorted_by_distance = []
        for i in range(1, n + 1):
            nodes_sorted_by_distance.append((dist[i], i))

        nodes_sorted_by_distance.sort()

        for _, u in nodes_sorted_by_distance:
            if u == n:
                continue

            for v, _ in adj[u]:
                if dist[u] > dist[v]:
                    dp[u] = (dp[u] + dp[v]) % MOD

        return dp[1]