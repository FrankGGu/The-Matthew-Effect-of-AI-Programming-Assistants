class Solution:
    def numberOfWays(self, s: str) -> int:
        n = len(s)
        mod = 10**9 + 7
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        def compare(i, j, k, l):
            if j - i != l - k:
                return j - i > l - k
            while i < j:
                if s[i] != s[k]:
                    return s[i] > s[k]
                i += 1
                k += 1
            return False

        for i in range(1, n + 1):
            for j in range(1, i + 1):
                if s[i - j] == '0':
                    dp[i][j] = 0
                    continue
                if j == i:
                    dp[i][j] = 1
                    continue
                dp[i][j] = dp[i][j - 1]
                if i - j >= j and not compare(i - 2 * j, i - j, i - j, i):
                    dp[i][j] = (dp[i][j] + dp[i - j][j]) % mod
                elif i - j < j:
                    dp[i][j] = (dp[i][j] + dp[i - j][i - j]) % mod

        ans = 0
        for j in range(1, n + 1):
            ans = (ans + dp[n][j]) % mod

        return ans