func maximumJumps(nums []int, target int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if dp[j] != -1 && abs(nums[i]-nums[j]) <= target {
                if dp[i] == -1 || dp[j]+1 > dp[i] {
                    dp[i] = dp[j] + 1
                }
            }
        }
    }

    return dp[n-1]
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}