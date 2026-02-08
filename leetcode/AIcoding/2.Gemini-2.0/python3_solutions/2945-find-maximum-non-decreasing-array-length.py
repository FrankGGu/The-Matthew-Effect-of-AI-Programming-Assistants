def findMaximumNonDecreasingLength(nums):
    n = len(nums)
    dp = [0] * n
    sums = [0] * n
    dp[0] = 1
    sums[0] = nums[0]
    ans = 1
    for i in range(1, n):
        sums[i] = sums[i - 1] + nums[i]
        dp[i] = 1
        for j in range(i):
            if (sums[i] - sums[j] >= sums[j] - (sums[j-1] if j > 0 else 0)):
                dp[i] = max(dp[i], dp[j] + 1)
        ans = max(ans, dp[i])
    return ans