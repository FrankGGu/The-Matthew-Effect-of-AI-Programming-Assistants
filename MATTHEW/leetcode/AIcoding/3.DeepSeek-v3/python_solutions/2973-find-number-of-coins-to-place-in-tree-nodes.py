from collections import defaultdict

class Solution:
    def placeCoins(self, edges, cost):
        n = len(cost) + 1
        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        parent = [0] * n
        children = [[] for _ in range(n)]
        stack = [0]
        parent[0] = -1
        while stack:
            u = stack.pop()
            for v in tree[u]:
                if v != parent[u]:
                    parent[v] = u
                    children[u].append(v)
                    stack.append(v)

        dp = [0] * n
        res = [0] * n

        def dfs(u):
            nonlocal dp, res
            dp[u] = cost[u]
            for v in children[u]:
                dfs(v)
                dp[u] += dp[v]
            res[u] = abs(dp[u])

        dfs(0)
        return res