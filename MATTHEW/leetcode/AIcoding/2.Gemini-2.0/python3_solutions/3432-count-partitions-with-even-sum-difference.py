def countPartitions(nums: list[int], d: int) -> int:
    s = sum(nums)
    if (s - d) % 2 != 0 or s < d:
        return 0
    target = (s - d) // 2
    mod = 10**9 + 7
    dp = [0] * (target + 1)
    dp[0] = 1
    for num in nums:
        for j in range(target, num - 1, -1):
            dp[j] = (dp[j] + dp[j - num]) % mod
    return dp[target]