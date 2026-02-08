class Solution:
    def maxStarSum(self, vals: List[int], edges: List[List[int]], k: int) -> int:
        from collections import defaultdict
        graph = defaultdict(list)

        for u, v in edges:
            graph[u].append(vals[v])
            graph[v].append(vals[u])

        max_sum = 0

        for i in range(len(vals)):
            max_sum += vals[i]
            neighbors = sorted(graph[i], reverse=True)
            for j in range(min(k, len(neighbors))):
                if neighbors[j] > 0:
                    max_sum += neighbors[j]

        return max_sum