func minCost(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    dp := make([]int, len(nums)+1)
    dp[0] = 0
    for i := 1; i <= len(nums); i++ {
        dp[i] = dp[i-1] + count[nums[i-1]]
    }

    minCost := dp[len(nums)]
    for i := 1; i <= len(nums); i++ {
        minCost = min(minCost, dp[i]+count[nums[i-1]]-count[nums[i-1]])
    }

    return minCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}