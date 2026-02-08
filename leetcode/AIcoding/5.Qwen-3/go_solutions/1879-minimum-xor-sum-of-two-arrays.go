package main

func minXORSum(nums1 []int, nums2 []int) int {
    n := len(nums1)
    m := 1 << n
    dp := make([]int, m)
    for i := range dp {
        dp[i] = 1 << 30
    }
    dp[0] = 0
    for mask := 0; mask < m; mask++ {
        cnt := 0
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                cnt++
            }
        }
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 {
                newMask := mask | (1 << i)
                dp[newMask] = min(dp[newMask], dp[mask]+(nums1[i]^nums2[cnt]))
            }
        }
    }
    return dp[m-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}