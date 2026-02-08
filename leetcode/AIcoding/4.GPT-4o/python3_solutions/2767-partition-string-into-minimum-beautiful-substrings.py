class Solution:
    def minimumBeautifulSubstrings(self, s: str) -> int:
        def is_beautiful(x):
            return x and ((x & (x - 1)) == 0)

        n = len(s)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            num = 0
            for j in range(i, 0, -1):
                num = (num << 1) + (s[j - 1] == '1')
                if is_beautiful(num):
                    dp[i] = min(dp[i], dp[j - 1] + 1)

        return dp[n] if dp[n] != float('inf') else -1