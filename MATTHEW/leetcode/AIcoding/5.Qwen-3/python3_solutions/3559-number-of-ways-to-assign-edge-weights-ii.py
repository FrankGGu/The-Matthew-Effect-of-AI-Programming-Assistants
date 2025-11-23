class Solution:
    def waysToAssignEdgeWeights(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(u, parent):
            nonlocal count
            for v in adj[u]:
                if v != parent:
                    dfs(v, u)
                    count += 1

        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        count = 0
        dfs(0, -1)
        return pow(2, count)