func minimumDifference(nums []int) int {
    n := len(nums) / 2
    sum := 0
    for _, num := range nums {
        sum += num
    }

    dp := make([][]bool, n+1)
    for i := range dp {
        dp[i] = make([]bool, sum/2+1)
    }
    dp[0][0] = true

    for i := 0; i < n; i++ {
        for j := sum / 2; j >= nums[i]; j-- {
            for k := n; k >= 1; k-- {
                dp[k][j] = dp[k][j] || dp[k-1][j-nums[i]]
            }
        }
    }

    res := math.MaxInt32
    for j := 0; j <= sum/2; j++ {
        if dp[n][j] {
            res = min(res, abs(sum-2*j))
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}