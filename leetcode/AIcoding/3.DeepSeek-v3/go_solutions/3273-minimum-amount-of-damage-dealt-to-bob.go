func minimumDamageDealtToBob(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 1; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            for k := i; k <= j; k++ {
                left := 1
                if i != 0 {
                    left = nums[i-1]
                }
                right := 1
                if j != n-1 {
                    right = nums[j+1]
                }

                before := 0
                if k != i {
                    before = dp[i][k-1]
                }
                after := 0
                if k != j {
                    after = dp[k+1][j]
                }
                current := left * nums[k] * right + before + after
                if dp[i][j] < current {
                    dp[i][j] = current
                }
            }
        }
    }

    return dp[0][n-1]
}