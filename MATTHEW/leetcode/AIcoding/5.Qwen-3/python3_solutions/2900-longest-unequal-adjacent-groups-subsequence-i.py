class Solution:
    def getLongestSubsequence(self, s: str, k: int) -> str:
        n = len(s)
        dp = [1] * n
        prev = [-1] * n

        for i in range(n):
            for j in range(i):
                if abs(ord(s[i]) - ord(s[j])) > k and dp[j] + 1 > dp[i]:
                    dp[i] = dp[j] + 1
                    prev[i] = j

        max_len = max(dp)
        index = dp.index(max_len)

        result = []
        while index != -1:
            result.append(s[index])
            index = prev[index]

        return ''.join(reversed(result))