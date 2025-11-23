class Solution:
    def countPairs(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * n
        component_sizes = []

        def dfs(node):
            stack = [node]
            size = 0
            while stack:
                curr = stack.pop()
                if not visited[curr]:
                    visited[curr] = True
                    size += 1
                    for neighbor in graph[curr]:
                        if not visited[neighbor]:
                            stack.append(neighbor)
            return size

        for i in range(n):
            if not visited[i]:
                component_size = dfs(i)
                component_sizes.append(component_size)

        total_pairs = n * (n - 1) // 2
        connected_pairs = sum(size * (size - 1) // 2 for size in component_sizes)

        return total_pairs - connected_pairs