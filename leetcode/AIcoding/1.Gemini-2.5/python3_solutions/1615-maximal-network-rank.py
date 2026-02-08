class Solution:
    def maximalNetworkRank(self, n: int, roads: list[list[int]]) -> int:
        degree = [0] * n
        adj = [set() for _ in range(n)]

        for u, v in roads:
            degree[u] += 1
            degree[v] += 1
            adj[u].add(v)
            adj[v].add(u)

        max_rank = 0

        for i in range(n):
            for j in range(i + 1, n):
                current_rank = degree[i] + degree[j]
                if j in adj[i]:
                    current_rank -= 1
                max_rank = max(max_rank, current_rank)

        return max_rank