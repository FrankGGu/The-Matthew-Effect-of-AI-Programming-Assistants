package main

func numBalancedPermutations(n int, k int) int {
    mod := 1000000007
    maxN := n * 2
    fact := make([]int, maxN+1)
    invFact := make([]int, maxN+1)
    fact[0] = 1
    for i := 1; i <= maxN; i++ {
        fact[i] = fact[i-1] * i % mod
    }
    invFact[maxN] = pow(fact[maxN], mod-2, mod)
    for i := maxN - 1; i >= 0; i-- {
        invFact[i] = invFact[i+1] * (i+1) % mod
    }
    comb := func(a, b int) int {
        if a < 0 || b < 0 || a < b {
            return 0
        }
        return fact[a] * invFact[b] % mod * invFact[a-b] % mod
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1
    for i := 0; i < n; i++ {
        for j := 0; j <= i; j++ {
            if dp[i][j] == 0 {
                continue
            }
            for a := 0; a <= i-j; a++ {
                for b := 0; b <= i-j-a; b++ {
                    c := i - j - a - b
                    if a+b+c != i-j {
                        continue
                    }
                    if a > 0 {
                        dp[i+1][j+a] = (dp[i+1][j+a] + dp[i][j] * comb(i-j, a)) % mod
                    }
                    if b > 0 {
                        dp[i+1][j+b] = (dp[i+1][j+b] + dp[i][j] * comb(i-j, b)) % mod
                    }
                    if c > 0 {
                        dp[i+1][j+c] = (dp[i+1][j+c] + dp[i][j] * comb(i-j, c)) % mod
                    }
                }
            }
        }
    }
    return dp[n][k]
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