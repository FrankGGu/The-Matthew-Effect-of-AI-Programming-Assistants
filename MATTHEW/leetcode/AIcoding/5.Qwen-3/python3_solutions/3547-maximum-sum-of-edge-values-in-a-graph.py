class Solution:
    def maxEdgeSum(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * (n + 1)
        max_sum = 0

        def dfs(node):
            nonlocal max_sum
            visited[node] = True
            current_sum = node
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    current_sum += dfs(neighbor)
            max_sum = max(max_sum, current_sum)
            return current_sum

        for i in range(1, n + 1):
            if not visited[i]:
                dfs(i)

        return max_sum