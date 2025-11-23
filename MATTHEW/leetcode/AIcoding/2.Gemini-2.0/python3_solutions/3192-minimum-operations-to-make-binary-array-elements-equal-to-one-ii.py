def minOperations(nums: list[int]) -> int:
    n = len(nums)
    dp = [[float('inf')] * 2 for _ in range(n + 1)]
    dp[0][0] = 0
    dp[0][1] = float('inf')

    for i in range(1, n + 1):
        dp[i][0] = dp[i - 1][0]
        dp[i][1] = dp[i - 1][1]

        if nums[i - 1] == 0:
            dp[i][1] = min(dp[i][1], dp[i - 1][0] + 1)
        else:
            dp[i][0] = min(dp[i][0], dp[i - 1][0])

        if i > 1:
            if nums[i - 1] == 0 and nums[i - 2] == 0:
                dp[i][0] = min(dp[i][0], dp[i - 2][1])
            if nums[i - 1] == 1 and nums[i - 2] == 1:
                dp[i][1] = min(dp[i][1], dp[i - 2][0] + 1)
            if nums[i-1] == 0 and nums[i-2] == 1:
                dp[i][0] = min(dp[i][0], dp[i-2][1])
            if nums[i-1] == 1 and nums[i-2] == 0:
                dp[i][1] = min(dp[i][1], dp[i-2][0] + 1)

    return min(dp[n][0], dp[n][1])