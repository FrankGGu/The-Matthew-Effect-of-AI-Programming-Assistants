package main

func maximumTotalDamage(abilities []int) int {
    maxAbility := 0
    for _, a := range abilities {
        if a > maxAbility {
            maxAbility = a
        }
    }

    damage := make([]int, maxAbility+1)
    for _, a := range abilities {
        damage[a]++
    }

    dp := make([]int, maxAbility+2)
    for i := 1; i <= maxAbility; i++ {
        if damage[i] == 0 {
            dp[i] = dp[i-1]
        } else {
            dp[i] = dp[i-1]
            if i >= 2 {
                dp[i] = max(dp[i], dp[i-2]+damage[i]*i)
            } else {
                dp[i] = max(dp[i], damage[i]*i)
            }
        }
    }

    return dp[maxAbility]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}