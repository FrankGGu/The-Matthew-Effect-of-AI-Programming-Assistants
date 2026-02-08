def maximize_total_cost(nums: list[int]) -> int:
    n = len(nums)
    dp = [[0, 0] for _ in range(n)]  # dp[i][0]: ending at i, last is positive, dp[i][1]: ending at i, last is negative
    dp[0][0] = nums[0]
    dp[0][1] = 0

    for i in range(1, n):
        dp[i][0] = max(dp[i - 1][1] + nums[i], nums[i])
        dp[i][1] = max(dp[i - 1][0] - nums[i], 0)

    return max(dp[n - 1][0], dp[n - 1][1])