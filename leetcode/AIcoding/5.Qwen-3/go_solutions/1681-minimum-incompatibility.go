package main

func minIncompatity(nums []int, k int) int {
    n := len(nums)
    if k == n {
        return 0
    }
    if k == 1 {
        return 0
    }
    sort.Ints(nums)
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0
    for mask := 0; mask < (1 << n); mask++ {
        if dp[mask] == -1 {
            continue
        }
        cnt := 0
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                cnt++
            }
        }
        if cnt == k {
            continue
        }
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 {
                nextMask := mask | (1 << i)
                if dp[nextMask] == -1 {
                    dp[nextMask] = dp[mask] + nums[i]
                } else {
                    dp[nextMask] = min(dp[nextMask], dp[mask]+nums[i])
                }
            }
        }
    }
    return dp[(1<<n)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}