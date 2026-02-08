package main

func idealArrays(n int, m int) int {
    mod := 1000000007
    max := 100000
    dp := make([]int, max+1)
    for i := 1; i <= max; i++ {
        dp[i] = 1
    }
    for i := 2; i <= max; i++ {
        for j := i; j <= max; j += i {
            dp[j] = (dp[j] + dp[i]) % mod
        }
    }
    res := 0
    for i := 1; i <= max; i++ {
        if i > m {
            break
        }
        cnt := dp[m/i]
        res = (res + cnt) % mod
    }
    return res
}