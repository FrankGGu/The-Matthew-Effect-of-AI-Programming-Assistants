class Solution:
    def numberOfWays(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        result = 1

        def dfs(node, parent):
            nonlocal result
            count = 1
            for neighbor in graph[node]:
                if neighbor != parent:
                    child_count = dfs(neighbor, node)
                    count += child_count
            return count

        for i in range(n):
            if i not in graph:
                continue
            for j in graph[i]:
                if j > i:
                    size = dfs(i, -1)
                    result *= size
                    result %= 10**9 + 7
        return result