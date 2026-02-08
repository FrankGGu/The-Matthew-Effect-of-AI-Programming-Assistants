func minSpaceWastedKResizing(nums []int, k int) int {
    n := len(nums)
    maxBetween := make([][]int, n)
    for i := range maxBetween {
        maxBetween[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        maxVal := nums[i]
        sum := nums[i]
        for j := i + 1; j < n; j++ {
            if nums[j] > maxVal {
                maxVal = nums[j]
            }
            sum += nums[j]
            maxBetween[i][j] = maxVal*(j-i+1) - sum
        }
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+2)
        for j := range dp[i] {
            dp[i][j] = 1 << 30
        }
    }

    for i := 0; i < n; i++ {
        for j := 1; j <= k+1; j++ {
            for l := 0; l <= i; l++ {
                if l == 0 {
                    dp[i][j] = maxBetween[l][i]
                } else {
                    if dp[l-1][j-1]+maxBetween[l][i] < dp[i][j] {
                        dp[i][j] = dp[l-1][j-1] + maxBetween[l][i]
                    }
                }
            }
        }
    }

    return dp[n-1][k+1]
}