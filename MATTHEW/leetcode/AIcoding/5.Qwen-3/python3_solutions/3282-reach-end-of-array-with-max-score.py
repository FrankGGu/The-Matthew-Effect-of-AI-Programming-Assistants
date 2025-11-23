class Solution:
    def maxScore(self, arr: List[int]) -> int:
        n = len(arr)
        dp = [0] * n
        dp[0] = arr[0]
        for i in range(1, n):
            max_val = 0
            for j in range(i):
                if j + arr[j] >= i:
                    max_val = max(max_val, dp[j])
            dp[i] = max_val + arr[i]
        return dp[-1]