class Solution:
    def minTotalPrice(self, n: int, edges: List[List[int]], price: List[int], trips: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [0] * n
        depth = [0] * n
        visited = [False] * n

        def dfs(u, p):
            visited[u] = True
            parent[u] = p
            for v in graph[u]:
                if not visited[v]:
                    depth[v] = depth[u] + 1
                    dfs(v, u)

        dfs(0, -1)

        count = [0] * n

        def lca(u, v):
            while depth[u] > depth[v]:
                u = parent[u]
            while depth[v] > depth[u]:
                v = parent[v]
            while u != v:
                u = parent[u]
                v = parent[v]
            return u

        def update_count(u, target):
            while u != target:
                count[u] += 1
                u = parent[u]
            count[target] += 1

        for u, v in trips:
            ancestor = lca(u, v)
            update_count(u, ancestor)
            update_count(v, ancestor)

        dp = [0] * n

        def post_order(u, p):
            for v in graph[u]:
                if v != p:
                    post_order(v, u)
                    dp[u] += dp[v]
            dp[u] += price[u] * count[u]

        post_order(0, -1)

        return dp[0]