import heapq

class Solution:
    def countRestrictedPaths(self, n: int, edges: List[List[int]]) -> int:
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        dist = [float('inf')] * (n + 1)
        dist[n] = 0
        heap = [(0, n)]

        while heap:
            current_dist, u = heapq.heappop(heap)
            if current_dist > dist[u]:
                continue
            for v, w in graph[u]:
                if dist[v] > dist[u] + w:
                    dist[v] = dist[u] + w
                    heapq.heappush(heap, (dist[v], v))

        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        dp[n] = 1

        nodes = sorted(range(1, n + 1), key=lambda x: dist[x])

        for u in nodes:
            for v, _ in graph[u]:
                if dist[u] > dist[v]:
                    dp[u] = (dp[u] + dp[v]) % MOD

        return dp[1] % MOD