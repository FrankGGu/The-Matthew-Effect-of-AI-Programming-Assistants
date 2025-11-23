func specialPerm(nums []int) int {
    mod := 1000000007
    n := len(nums)
    dp := make([][]int, 1<<n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        dp[1<<i][i] = 1
    }

    for mask := 1; mask < (1 << n); mask++ {
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 {
                continue
            }
            for j := 0; j < n; j++ {
                if mask&(1<<j) != 0 || i == j {
                    continue
                }
                if nums[i]%nums[j] == 0 || nums[j]%nums[i] == 0 {
                    dp[mask|(1<<j)][j] = (dp[mask|(1<<j)][j] + dp[mask][i]) % mod
                }
            }
        }
    }

    totalPerms := 0
    for i := 0; i < n; i++ {
        totalPerms = (totalPerms + dp[(1<<n)-1][i]) % mod
    }

    return totalPerms
}