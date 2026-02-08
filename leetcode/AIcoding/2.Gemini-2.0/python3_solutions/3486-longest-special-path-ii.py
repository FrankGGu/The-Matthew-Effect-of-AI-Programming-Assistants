from collections import defaultdict

class Solution:
    def longestSpecialPath(self, n: int, edges: list[list[int]], values: list[int]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        max_len = -1

        def dfs(node, visited, path_len, path_xor):
            nonlocal max_len
            visited.add(node)
            path_len += 1
            path_xor ^= values[node]

            if path_xor == 0:
                max_len = max(max_len, path_len)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor, visited.copy(), path_len, path_xor)

        for start_node in range(n):
            dfs(start_node, set(), 0, 0)

        return max_len