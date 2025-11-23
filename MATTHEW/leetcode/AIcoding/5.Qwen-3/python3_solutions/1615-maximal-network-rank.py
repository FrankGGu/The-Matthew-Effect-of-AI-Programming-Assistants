class Solution:
    def maximalNetworkRank(self, n: int, roads: List[List[int]]) -> int:
        from collections import defaultdict

        degree = [0] * n
        connected = defaultdict(set)

        for a, b in roads:
            degree[a] += 1
            degree[b] += 1
            connected[a].add(b)
            connected[b].add(a)

        max_rank = 0
        for i in range(n):
            for j in range(i + 1, n):
                if j not in connected[i]:
                    current_rank = degree[i] + degree[j]
                    max_rank = max(max_rank, current_rank)
        return max_rank