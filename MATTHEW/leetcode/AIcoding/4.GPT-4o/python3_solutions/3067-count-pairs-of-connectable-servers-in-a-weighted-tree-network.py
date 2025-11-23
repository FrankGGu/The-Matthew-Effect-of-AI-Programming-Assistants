class Solution:
    def countPairs(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict
        graph = defaultdict(list)

        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        sizes = []
        visited = [False] * n

        def dfs(node):
            visited[node] = True
            size = 1
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    size += dfs(neighbor)
            return size

        for i in range(n):
            if not visited[i]:
                sizes.append(dfs(i))

        total_pairs = n * (n - 1) // 2
        for size in sizes:
            total_pairs -= size * (size - 1) // 2

        return total_pairs