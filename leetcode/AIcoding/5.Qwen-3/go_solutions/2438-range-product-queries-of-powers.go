package main

func numSubseqsPowerOfTwo(nums []int, queries []int) []int {
    mod := 1000000007
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }
    for i := 1; i < n; i++ {
        if nums[i] == 0 {
            continue
        }
        for j := 0; j < i; j++ {
            if nums[j] != 0 && nums[i] > nums[j] {
                dp[i] = (dp[i] + dp[j]) % mod
            }
        }
    }
    res := make([]int, len(queries))
    for i := 0; i < len(queries); i++ {
        res[i] = dp[queries[i]]
    }
    return res
}