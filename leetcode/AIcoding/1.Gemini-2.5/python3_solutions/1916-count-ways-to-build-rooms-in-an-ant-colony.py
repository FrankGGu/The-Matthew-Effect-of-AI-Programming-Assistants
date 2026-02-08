import sys

class Solution:
    def waysToBuildRooms(self, parent: list[int]) -> int:
        n = len(parent)
        MOD = 10**9 + 7

        # Increase recursion limit for potentially deep trees
        sys.setrecursionlimit(n + 100) 

        # 1. Build adjacency list to represent the tree
        adj = [[] for _ in range(n)]
        for i in range(1, n):
            adj[parent[i]].append(i)

        # 2. Precompute factorials and inverse factorials modulo MOD
        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)

        for i in range(2, n + 1):
            fact[i] = (fact[i-1] * i) % MOD

        # Modular inverse using Fermat's Little Theorem: a^(MOD-2) % MOD
        # inv_fact[i] = (i!)^(-1) mod MOD
        inv_fact[n] = pow(fact[n], MOD - 2, MOD)
        for i in range(n - 1, 1, -1):
            inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD
        # inv_fact[0] and inv_fact[1] are correctly 1

        # 3. DFS to calculate subtree sizes and dp values
        # size[u]: number of nodes in the subtree rooted at u (including u)
        # dp[u]: number of ways to build the subtree rooted at u
        size = [0] * n
        dp = [0] * n 

        def dfs(u):
            size[u] = 1
            current_dp_product = 1  # Product of dp[v] for all children v of u
            inv_fact_size_product = 1 # Product of inv_fact[size[v]] for all children v of u

            for v in adj[u]:
                dfs(v)
                size[u] += size[v]
                current_dp_product = (current_dp_product * dp[v]) % MOD
                inv_fact_size_product = (inv_fact_size_product * inv_fact[size[v]]) % MOD

            # The formula for dp[u] is:
            # (size[u]-1)! / (size[c1]! * ... * size[ck]!) * product(dp[ci] for children ci)
            # This can be rewritten as:
            # fact[size[u]-1] * (product of inv_fact[size[ci]]) * (product of dp[ci])

            numerator_factorial = fact[size[u] - 1]

            # Combine all terms
            dp[u] = (numerator_factorial * inv_fact_size_product) % MOD
            dp[u] = (dp[u] * current_dp_product) % MOD

        # Start DFS from room 0 (the root of the ant colony)
        dfs(0)

        return dp[0]