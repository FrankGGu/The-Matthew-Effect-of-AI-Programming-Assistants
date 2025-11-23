import math
from collections import defaultdict

class Solution:
    def waysToBuildRooms(self, prevRoom: List[int]) -> int:
        mod = 10**9 + 7
        n = len(prevRoom)
        graph = defaultdict(list)
        for i in range(1, n):
            graph[prevRoom[i]].append(i)

        size = [1] * n
        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)

        for i in range(1, n + 1):
            fact[i] = fact[i-1] * i % mod

        inv_fact[n] = pow(fact[n], mod-2, mod)
        for i in range(n-1, -1, -1):
            inv_fact[i] = inv_fact[i+1] * (i+1) % mod

        res = 1
        def dfs(u):
            nonlocal res
            for v in graph[u]:
                dfs(v)
                size[u] += size[v]
            res = res * inv_fact[size[u]] % mod
            for v in graph[u]:
                res = res * fact[size[v]] % mod

        dfs(0)
        res = res * fact[n] % mod
        return res