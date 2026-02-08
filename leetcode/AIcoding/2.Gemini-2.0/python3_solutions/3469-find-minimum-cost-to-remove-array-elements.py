def minCost(nums: list[int]) -> int:
    n = len(nums)
    dp = [0] * (n + 1)
    nums.sort(reverse=True)
    for i in range(1, n + 1):
        dp[i] = dp[i - 1] + i * nums[i - 1]
    return dp[n]