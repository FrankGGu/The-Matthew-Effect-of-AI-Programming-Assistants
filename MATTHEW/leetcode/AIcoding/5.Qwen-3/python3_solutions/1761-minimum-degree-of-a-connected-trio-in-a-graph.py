class Solution:
    def minTrio(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(set)
        for u, v in edges:
            graph[u].add(v)
            graph[v].add(u)

        min_degree = float('inf')

        for i in range(1, n + 1):
            for j in graph[i]:
                if j <= i:
                    continue
                for k in graph[j]:
                    if k <= j:
                        continue
                    if k in graph[i]:
                        min_degree = min(min_degree, len(graph[i]) + len(graph[j]) + len(graph[k]) - 6)

        return min_degree if min_degree != float('inf') else 0