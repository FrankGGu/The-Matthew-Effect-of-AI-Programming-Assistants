class Solution:
    def minimumSubstringsInPartition(self, s: str) -> int:
        n = len(s)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            freq = {}
            for j in range(i, 0, -1):
                char = s[j - 1]
                freq[char] = freq.get(char, 0) + 1
                values = freq.values()
                if len(set(values)) == 1:
                    dp[i] = min(dp[i], dp[j - 1] + 1)

        return dp[n]