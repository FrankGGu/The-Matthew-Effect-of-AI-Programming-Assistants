class Solution:
    def beautifulPartitions(self, s: str, k: int, minLength: int) -> int:
        MOD = 10**9 + 7
        n = len(s)
        primes = {'2', '3', '5', '7'}

        if s[0] not in primes or s[-1] in primes:
            return 0

        dp = [[0] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for j in range(1, k + 1):
            prefix = 0
            for i in range(1, n + 1):
                if i >= minLength:
                    if s[i - minLength] in primes and (i - minLength == 0 or s[i - minLength - 1] not in primes):
                        prefix += dp[i - minLength][j - 1]
                        prefix %= MOD
                if s[i - 1] not in primes:
                    dp[i][j] = prefix

        return dp[n][k] % MOD