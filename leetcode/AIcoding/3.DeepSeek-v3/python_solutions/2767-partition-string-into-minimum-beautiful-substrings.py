class Solution:
    def minimumBeautifulSubstrings(self, s: str) -> int:
        n = len(s)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0
        power_of_5 = set()
        num = 1
        while num <= (1 << n) - 1:
            power_of_5.add(num)
            num *= 5

        for i in range(1, n + 1):
            for j in range(i):
                if s[j] == '0':
                    continue
                substr = s[j:i]
                num = int(substr, 2)
                if num in power_of_5:
                    dp[i] = min(dp[i], dp[j] + 1)

        return dp[n] if dp[n] != float('inf') else -1