package main

func nonNegativeIntegers(n int) int {
    if n == 0 {
        return 1
    }
    var dp [2]int
    dp[0] = 1
    dp[1] = 1
    for i := 2; i <= n; i++ {
        dp[i%2] = dp[(i-1)%2] + dp[(i-2)%2]
    }
    return dp[n%2]
}