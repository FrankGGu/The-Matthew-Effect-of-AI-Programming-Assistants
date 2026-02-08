class Solution:
    def maximumPoints(self, edges: List[List[int]], coins: List[int], k: int) -> int:
        from functools import lru_cache

        n = len(coins)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [ -1 ] * n
        stack = [(0, -1)]
        order = []
        while stack:
            u, p = stack.pop()
            parent[u] = p
            order.append(u)
            for v in graph[u]:
                if v != p:
                    stack.append((v, u))

        @lru_cache(maxsize=None)
        def dfs(u, t):
            if t >= 14:
                return 0
            res1 = (coins[u] >> t) - k
            res2 = coins[u] >> (t + 1)
            for v in graph[u]:
                if v != parent[u]:
                    res1 += dfs(v, t)
                    res2 += dfs(v, t + 1)
            return max(res1, res2)

        return dfs(0, 0)