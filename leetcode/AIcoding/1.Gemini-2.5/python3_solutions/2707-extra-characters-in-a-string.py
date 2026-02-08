class Solution:
    def minExtraChar(self, s: str, dictionary: list[str]) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        word_set = set(dictionary)

        for i in range(1, n + 1):
            # Option 1: The current character s[i-1] is an extra character
            dp[i] = dp[i-1] + 1

            # Option 2: Check if any substring ending at s[i-1] is a valid word
            # If s[j...i-1] is a valid word, then dp[i] can be dp[j]
            for j in range(i):
                substring = s[j:i]
                if substring in word_set:
                    dp[i] = min(dp[i], dp[j])

        return dp[n]