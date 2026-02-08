class Solution:
    def idealArrays(self, n: int, maxValue: int) -> int:
        MOD = 10**9 + 7

        max_k = min(n.bit_length() + 1, maxValue.bit_length() + 1)

        dp = [[0] * (maxValue + 1) for _ in range(max_k + 1)]
        for v in range(1, maxValue + 1):
            dp[1][v] = 1

        for k in range(2, max_k + 1):
            for v in range(1, maxValue + 1):
                for m in range(2, maxValue // v + 1):
                    dp[k][v * m] = (dp[k][v * m] + dp[k - 1][v]) % MOD

        fact = [1] * (max_k + 1)
        for i in range(1, max_k + 1):
            fact[i] = fact[i - 1] * i % MOD

        inv_fact = [1] * (max_k + 1)
        inv_fact[max_k] = pow(fact[max_k], MOD - 2, MOD)
        for i in range(max_k - 1, -1, -1):
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD

        res = 0
        for k in range(1, max_k + 1):
            C = fact[n] * inv_fact[k] % MOD * inv_fact[n - k] % MOD
            res = (res + C * sum(dp[k][v] for v in range(1, maxValue + 1))) % MOD

        return res