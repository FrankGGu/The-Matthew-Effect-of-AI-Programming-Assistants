def maxSum(nums, m, k):
    n = len(nums)
    if n < m * k:
        return -1

    prefix_sum = [0] * (n + 1)
    for i in range(1, n + 1):
        prefix_sum[i] = prefix_sum[i - 1] + nums[i - 1]

    dp = [[float('-inf')] * (k + 1) for _ in range(n + 1)]
    dp[0][0] = 0

    for i in range(1, n + 1):
        for j in range(k + 1):
            dp[i][j] = dp[i - 1][j]
            if j > 0 and i >= m:
                dp[i][j] = max(dp[i][j], dp[i - m][j - 1] + (prefix_sum[i] - prefix_sum[i - m]))

    return dp[n][k]