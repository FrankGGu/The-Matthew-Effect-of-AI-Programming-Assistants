class Solution:
    def maxSumAfterPartitioning(self, arr: List[int], k: int) -> int:
        n = len(arr)
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            max_val = 0
            for j in range(i - 1, max(i - k - 1, -1), -1):
                max_val = max(max_val, arr[j])
                dp[i] = max(dp[i], dp[j] + max_val)
        return dp[n]