class Solution:
    def minimumConcat(self, words: list[str], target: str) -> int:
        n = len(target)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            for word in words:
                word_len = len(word)
                if i >= word_len and target[i - word_len:i] == word:
                    if dp[i - word_len] != float('inf'):
                        dp[i] = min(dp[i], dp[i - word_len] + 1)

        return dp[n] if dp[n] != float('inf') else -1