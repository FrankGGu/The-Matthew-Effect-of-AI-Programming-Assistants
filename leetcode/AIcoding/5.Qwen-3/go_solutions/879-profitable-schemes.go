package main

func profitableSchemes(target int, k int, group []int, profit []int) int {
    MOD := int(1e9 + 7)
    dp := make([][]int, target+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 0; i <= k; i++ {
        dp[0][i] = 1
    }
    for i := 0; i < len(group); i++ {
        g := group[i]
        p := profit[i]
        for j := target; j >= 0; j-- {
            for l := k; l >= 0; l-- {
                if l+g <= k {
                    dp[j][l+g] = (dp[j][l+g] + dp[j][l]) % MOD
                    if j+p <= target {
                        dp[j+p][l+g] = (dp[j+p][l+g] + dp[j][l]) % MOD
                    }
                }
            }
        }
    }
    res := 0
    for i := 0; i <= k; i++ {
        res = (res + dp[target][i]) % MOD
    }
    return res
}