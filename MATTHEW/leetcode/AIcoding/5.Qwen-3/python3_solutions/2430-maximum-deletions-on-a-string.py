class Solution:
    def maximumDeletions(self, s: str) -> int:
        from collections import Counter

        def is_valid(s):
            count = Counter(s)
            for c in count:
                if count[c] > 1:
                    return False
            return True

        n = len(s)
        dp = [0] * (n + 1)
        for i in range(n):
            for j in range(i + 1, n + 1):
                if is_valid(s[i:j]):
                    dp[j] = max(dp[j], dp[i] + 1)
        return dp[n]