class Solution:
    def minOperations(self, s1: str, s2: str, x: int) -> int:
        diff_indices = [i for i in range(len(s1)) if s1[i] != s2[i]]
        if len(diff_indices) % 2 != 0:
            return -1
        if not diff_indices:
            return 0

        n = len(diff_indices)
        dp = [float('inf')] * n
        dp[0] = x / 2  # cost for flipping one bit (half of operation 1)
        if n > 1:
            dp[1] = min(x, diff_indices[1] - diff_indices[0])

        for i in range(2, n):
            dp[i] = min(dp[i-1] + x / 2, dp[i-2] + (diff_indices[i] - diff_indices[i-1]))

        return int(dp[-1]) if dp[-1] != float('inf') else -1