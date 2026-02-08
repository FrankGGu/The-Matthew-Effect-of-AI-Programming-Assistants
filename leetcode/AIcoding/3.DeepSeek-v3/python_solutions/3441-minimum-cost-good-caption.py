class Solution:
    def minimumCost(self, sentence: str, k: int) -> int:
        words = sentence.split()
        n = len(words)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            current_len = 0
            for j in range(i, 0, -1):
                current_len += len(words[j - 1])
                if current_len + (i - j) > k:
                    break
                cost = 0 if i == n else (k - (current_len + (i - j))) ** 2
                dp[i] = min(dp[i], dp[j - 1] + cost)

        return dp[n]