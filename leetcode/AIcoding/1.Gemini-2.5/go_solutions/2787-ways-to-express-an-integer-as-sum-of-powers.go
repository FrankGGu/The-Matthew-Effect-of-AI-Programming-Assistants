package main

import "math"

func waysToExpressAnIntegerAsSumOfPowers(n int, x int) int {
    const MOD = 1e9 + 7

    dp := make([]int, n+1)
    dp[0] = 1 // There is one way to form a sum of 0 (by choosing no numbers)

    // Iterate through possible base numbers (a_i) starting from 1
    for i := 1; ; i++ {
        // Calculate a_i^x
        // Using a custom loop for integer power to avoid float precision issues,
        // though for given constraints math.Pow would likely be fine.
        currentPower := 1
        for k := 0; k < x; k++ {
            currentPower *= i
        }

        // If the current power exceeds n, no further powers can be used to reach n.
        if currentPower > n {
            break
        }

        // Use 0/1 knapsack approach: iterate j (current sum) downwards.
        // This ensures that each power (i^x) is used at most once in any sum combination,
        // fulfilling the "unique positive integers" requirement for the bases a_i.
        for j := n; j >= currentPower; j-- {
            dp[j] = (dp[j] + dp[j-currentPower]) % MOD
        }
    }

    return dp[n]
}