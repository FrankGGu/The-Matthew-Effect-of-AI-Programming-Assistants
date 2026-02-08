class Solution:
    def maximumSum(self, arr: List[int]) -> int:
        n = len(arr)
        dp = [[0, 0] for _ in range(n)]
        dp[0][0] = arr[0]
        dp[0][1] = 0
        max_sum = arr[0]

        for i in range(1, n):
            dp[i][0] = max(arr[i], dp[i - 1][0] + arr[i])
            dp[i][1] = max(dp[i - 1][0], dp[i - 1][1] + arr[i])
            max_sum = max(max_sum, dp[i][0], dp[i][1])

        return max_sum