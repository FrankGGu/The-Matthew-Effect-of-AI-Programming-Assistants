class Solution:
    def minimumNumbers(self, target: str, valid_strings: list[str]) -> int:
        n = len(target)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        valid_set = set(valid_strings)

        max_len = 0
        for s in valid_strings:
            max_len = max(max_len, len(s))

        for i in range(1, n + 1):
            for j in range(max(0, i - max_len), i):
                sub = target[j:i]
                if sub in valid_set:
                    if dp[j] != float('inf'):
                        dp[i] = min(dp[i], dp[j] + 1)

        return dp[n] if dp[n] != float('inf') else -1