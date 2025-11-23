package main

func numberOfWays(nums []int) int {
    mod := int64(1000000007)
    n := len(nums)
    dp := make([]int64, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = (dp[i-1] * int64(i)) % mod
    }
    res := int64(0)
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            continue
        }
        cnt := 0
        for j := 0; j < n; j++ {
            if nums[j] != 0 && nums[j]%nums[i] == 0 {
                cnt++
            }
        }
        res = (res + dp[cnt]) % mod
    }
    return int(res)
}