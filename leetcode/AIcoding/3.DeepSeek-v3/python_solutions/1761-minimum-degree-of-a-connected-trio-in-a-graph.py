class Solution:
    def minTrioDegree(self, n: int, edges: List[List[int]]) -> int:
        graph = [set() for _ in range(n + 1)]
        degree = [0] * (n + 1)

        for u, v in edges:
            graph[u].add(v)
            graph[v].add(u)
            degree[u] += 1
            degree[v] += 1

        min_degree = float('inf')

        for u in range(1, n + 1):
            neighbors = graph[u]
            for v in neighbors:
                if v > u:
                    for w in neighbors:
                        if w > v and w in graph[v]:
                            current_degree = degree[u] + degree[v] + degree[w] - 6
                            if current_degree < min_degree:
                                min_degree = current_degree

        return min_degree if min_degree != float('inf') else -1