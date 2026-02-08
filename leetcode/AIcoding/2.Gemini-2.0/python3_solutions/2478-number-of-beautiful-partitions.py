class Solution:
    def numberOfBeautifulPartitions(self, s: str, k: int, minLength: int) -> int:
        MOD = 10**9 + 7
        n = len(s)
        primes = {2, 3, 5, 7}
        if int(s[0]) not in primes:
            return 0

        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            for j in range(max(0, i - minLength), i):
                if i - j >= minLength and int(s[j]) in primes and (i == n or int(s[i - 1]) not in primes):
                    dp[i] = (dp[i] + dp[j]) % MOD

        return dp[n]