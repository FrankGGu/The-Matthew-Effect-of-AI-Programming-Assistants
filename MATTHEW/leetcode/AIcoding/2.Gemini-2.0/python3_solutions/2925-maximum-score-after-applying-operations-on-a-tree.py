class Solution:
    def maximumScoreAfterOperations(self, edges: list[list[int]], values: list[int]) -> int:
        n = len(values)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            leaf = values[node]
            non_leaf = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    res = dfs(neighbor, node)
                    leaf += res[1]
                    non_leaf += res[0]
            return max(values[node] - leaf, 0) + non_leaf, values[node]

        return dfs(0, -1)[0]