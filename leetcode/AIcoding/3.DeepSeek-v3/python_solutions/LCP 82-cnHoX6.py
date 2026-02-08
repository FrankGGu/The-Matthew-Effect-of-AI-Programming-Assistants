class Solution:
    def treeOfInfiniteSouls(self, gem: List[int], p: int, target: int) -> int:
        n = len(gem)
        mod = 10**9 + 7

        # Precompute factorials and inverse factorials modulo mod
        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)
        for i in range(1, n + 1):
            fact[i] = fact[i-1] * i % mod
            inv_fact[i] = pow(fact[i], mod-2, mod)

        # Precompute the number of valid permutations for each possible sum
        dp = [0] * (target + 1)
        dp[0] = 1

        for num in gem:
            power = pow(num, p, mod)
            for s in range(target, power - 1, -1):
                dp[s] = (dp[s] + dp[s - power]) % mod

        return (dp[target] * fact[n]) % mod