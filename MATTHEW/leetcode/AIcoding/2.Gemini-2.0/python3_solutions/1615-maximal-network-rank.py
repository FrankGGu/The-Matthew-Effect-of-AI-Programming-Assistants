class Solution:
    def maximalNetworkRank(self, n: int, roads: List[List[int]]) -> int:
        adj = [set() for _ in range(n)]
        for u, v in roads:
            adj[u].add(v)
            adj[v].add(u)

        max_rank = 0
        for i in range(n):
            for j in range(i + 1, n):
                rank = len(adj[i]) + len(adj[j])
                if i in adj[j]:
                    rank -= 1
                max_rank = max(max_rank, rank)

        return max_rank