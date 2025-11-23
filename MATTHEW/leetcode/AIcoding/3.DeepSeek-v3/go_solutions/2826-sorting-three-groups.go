func minimumOperations(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([][4]int, n)
    for i := 0; i < n; i++ {
        for j := 1; j <= 3; j++ {
            cost := 0
            if nums[i] != j {
                cost = 1
            }
            if i == 0 {
                dp[i][j] = cost
            } else {
                minPrev := dp[i-1][1]
                for k := 1; k <= j; k++ {
                    if dp[i-1][k] < minPrev {
                        minPrev = dp[i-1][k]
                    }
                }
                dp[i][j] = minPrev + cost
            }
        }
    }

    res := dp[n-1][1]
    if dp[n-1][2] < res {
        res = dp[n-1][2]
    }
    if dp[n-1][3] < res {
        res = dp[n-1][3]
    }
    return res
}