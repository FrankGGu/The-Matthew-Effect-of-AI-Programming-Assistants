def minCost(nums: List[int], k: int) -> int:
    n = len(nums)
    dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
    dp[0][0] = 0

    for i in range(1, n + 1):
        for j in range(1, k + 1):
            unique = set()
            cost = 0
            for x in range(i, 0, -1):
                if nums[x - 1] not in unique:
                    unique.add(nums[x - 1])
                    cost += 1
                dp[i][j] = min(dp[i][j], dp[x - 1][j - 1] + cost)

    return dp[n][k]