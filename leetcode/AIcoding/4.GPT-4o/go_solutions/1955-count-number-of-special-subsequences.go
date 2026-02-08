func countSpecialSubsequences(nums []int) int {
    mod := int(1e9 + 7)
    n := len(nums)
    dp := make([]int, n+1)
    dp[0] = 1
    count0, count1, count2 := 0, 0, 0

    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            count0 = (count0*2 + dp[i]) % mod
        } else if nums[i] == 1 {
            count1 = (count1*2 + count0) % mod
        } else if nums[i] == 2 {
            count2 = (count2*2 + count1) % mod
        }
        dp[i+1] = (dp[i] + count0 + count1 + count2) % mod
    }

    return count2
}