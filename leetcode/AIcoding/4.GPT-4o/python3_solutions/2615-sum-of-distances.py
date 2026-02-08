class Solution:
    def sumOfDistancesInTree(self, N: int, edges: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        count = [1] * N
        result = [0] * N

        def dfs(node, parent):
            for neighbor in graph[node]:
                if neighbor != parent:
                    dfs(neighbor, node)
                    count[node] += count[neighbor]
                    result[node] += result[neighbor] + count[neighbor]

        def dfs2(node, parent):
            for neighbor in graph[node]:
                if neighbor != parent:
                    result[neighbor] = result[node] - count[neighbor] + (N - count[neighbor])
                    dfs2(neighbor, node)

        dfs(0, -1)
        dfs2(0, -1)
        return result