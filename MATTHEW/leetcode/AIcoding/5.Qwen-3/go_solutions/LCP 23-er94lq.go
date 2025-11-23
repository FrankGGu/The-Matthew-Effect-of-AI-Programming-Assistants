package main

func numPermutationsOfN(n int, k int) int {
    mod := 1000000007
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] * i % mod
    }
    return dp[n] * pow(2, k, mod) % mod
}

func pow(a, b, mod int) int {
    result := 1
    for b > 0 {
        if b%2 == 1 {
            result = result * a % mod
        }
        a = a * a % mod
        b /= 2
    }
    return result
}