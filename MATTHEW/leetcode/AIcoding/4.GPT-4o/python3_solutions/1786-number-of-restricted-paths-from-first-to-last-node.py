class Solution:
    def countRestrictedPaths(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        dist = [float('inf')] * (n + 1)
        dist[n] = 0
        pq = [(0, n)]

        while pq:
            d, node = heapq.heappop(pq)
            if d > dist[node]:
                continue
            for neighbor, weight in graph[node]:
                if d + weight < dist[neighbor]:
                    dist[neighbor] = d + weight
                    heapq.heappush(pq, (dist[neighbor], neighbor))

        mod = 10**9 + 7
        dp = [0] * (n + 1)
        dp[n] = 1

        nodes = sorted(range(1, n + 1), key=lambda x: dist[x])
        for node in nodes:
            for neighbor, _ in graph[node]:
                if dist[node] > dist[neighbor]:
                    dp[node] = (dp[node] + dp[neighbor]) % mod

        return dp[1]