class Solution:
    def maximalNetworkRank(self, n: int, roads: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(set)
        for u, v in roads:
            graph[u].add(v)
            graph[v].add(u)

        max_rank = 0
        for i in range(n):
            for j in range(i + 1, n):
                rank = len(graph[i]) + len(graph[j]) - (1 if j in graph[i] else 0)
                max_rank = max(max_rank, rank)

        return max_rank