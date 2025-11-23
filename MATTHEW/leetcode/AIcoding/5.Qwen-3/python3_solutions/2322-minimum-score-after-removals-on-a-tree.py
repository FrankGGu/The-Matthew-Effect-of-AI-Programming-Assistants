class Solution:
    def minScore(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [0] * (n + 1)
        visited = [False] * (n + 1)
        size = [1] * (n + 1)

        def dfs(u):
            visited[u] = True
            for v in graph[u]:
                if not visited[v]:
                    parent[v] = u
                    dfs(v)
                    size[u] += size[v]

        dfs(1)

        total = n
        res = float('inf')
        for u in range(1, n + 1):
            for v in graph[u]:
                if parent[v] == u:
                    s = size[v]
                    res = min(res, abs(total - 2 * s))
        return res