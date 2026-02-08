class Solution:
    def sumOfDistancesInTree(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        count = [1] * n
        ans = [0] * n

        def dfs1(node, parent):
            for child in adj[node]:
                if child != parent:
                    dfs1(child, node)
                    count[node] += count[child]
                    ans[node] += ans[child] + count[child]

        dfs1(0, -1)

        def dfs2(node, parent):
            for child in adj[node]:
                if child != parent:
                    ans[child] = ans[node] - count[child] + (n - count[child])
                    dfs2(child, node)

        dfs2(0, -1)
        return ans