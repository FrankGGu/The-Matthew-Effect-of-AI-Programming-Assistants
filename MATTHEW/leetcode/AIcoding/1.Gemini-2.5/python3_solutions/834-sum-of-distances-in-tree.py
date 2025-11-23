from collections import defaultdict

class Solution:
    def sumOfDistancesInTree(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        count = [0] * n
        ans = [0] * n # Temporarily stores sum_dist_subtree in DFS1, then final answer in DFS2

        def dfs1(u, parent):
            count[u] = 1
            for v in adj[u]:
                if v != parent:
                    dfs1(v, u)
                    count[u] += count[v]
                    ans[u] += ans[v] + count[v]

        def dfs2(u, parent):
            for v in adj[u]:
                if v != parent:
                    ans[v] = ans[u] - count[v] + (n - count[v])
                    dfs2(v, u)

        dfs1(0, -1)
        dfs2(0, -1)

        return ans