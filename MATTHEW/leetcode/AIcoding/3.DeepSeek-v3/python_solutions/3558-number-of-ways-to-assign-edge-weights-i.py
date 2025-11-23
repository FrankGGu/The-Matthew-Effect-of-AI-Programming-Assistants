class Solution:
    def numberOfWays(self, n: int, edges: List[List[int]]) -> int:
        MOD = 10**9 + 7
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        res = 1

        def dfs(u, parent):
            nonlocal res
            cnt = 1
            for v in adj[u]:
                if v != parent:
                    child_cnt = dfs(v, u)
                    res = res * child_cnt % MOD
                    cnt += child_cnt
            return cnt

        dfs(0, -1)
        return res