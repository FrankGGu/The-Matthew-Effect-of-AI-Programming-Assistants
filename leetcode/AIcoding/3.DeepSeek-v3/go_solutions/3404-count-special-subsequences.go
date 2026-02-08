func countSpecialSubsequences(nums []int) int {
    mod := int(1e9 + 7)
    dp0, dp1, dp2 := 0, 0, 0
    for _, num := range nums {
        if num == 0 {
            dp0 = (dp0*2 + 1) % mod
        } else if num == 1 {
            dp1 = (dp1*2 + dp0) % mod
        } else if num == 2 {
            dp2 = (dp2*2 + dp1) % mod
        }
    }
    return dp2
}