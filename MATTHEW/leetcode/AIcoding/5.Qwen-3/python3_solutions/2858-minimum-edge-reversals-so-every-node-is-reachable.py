class Solution:
    def minEdgeReversals(self, n: int, edges: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        res = [0] * n

        def dfs(node, parent):
            for neighbor in graph[node]:
                if neighbor != parent:
                    res[node] += dfs(neighbor, node)
            return res[node]

        def dfs2(node, parent, count):
            res[node] = count
            for neighbor in graph[node]:
                if neighbor != parent:
                    dfs2(neighbor, node, count + (1 if neighbor in graph[node] else 0))

        dfs(0, -1)
        dfs2(0, -1, res[0])
        return res