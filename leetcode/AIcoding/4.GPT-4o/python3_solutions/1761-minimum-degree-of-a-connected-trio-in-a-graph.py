class Solution:
    def minTrioDegree(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(set)
        degree = [0] * (n + 1)

        for u, v in edges:
            graph[u].add(v)
            graph[v].add(u)
            degree[u] += 1
            degree[v] += 1

        min_degree = float('inf')

        for u in range(1, n + 1):
            for v in graph[u]:
                if v > u:
                    continue
                for w in graph[v]:
                    if w > v or w not in graph[u]:
                        continue
                    trio_degree = degree[u] + degree[v] + degree[w] - 6
                    min_degree = min(min_degree, trio_degree)

        return min_degree if min_degree != float('inf') else -1