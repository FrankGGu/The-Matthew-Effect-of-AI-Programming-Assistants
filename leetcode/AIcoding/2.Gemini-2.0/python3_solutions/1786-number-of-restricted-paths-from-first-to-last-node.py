import heapq

class Solution:
    def countRestrictedPaths(self, n: int, edges: List[List[int]]) -> int:
        graph = [[] for _ in range(n + 1)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        dist = [float('inf')] * (n + 1)
        dist[n] = 0
        pq = [(0, n)]

        while pq:
            d, u = heapq.heappop(pq)
            if d > dist[u]:
                continue
            for v, w in graph[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    heapq.heappush(pq, (dist[v], v))

        dp = [0] * (n + 1)
        dp[n] = 1

        def dfs(u):
            if dp[u] != 0:
                return dp[u]

            count = 0
            for v, _ in graph[u]:
                if dist[v] < dist[u]:
                    count = (count + dfs(v)) % (10**9 + 7)
            dp[u] = count
            return dp[u]

        return dfs(1)