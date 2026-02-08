package main

func maxEnergyDrinks(energyDrinkA []int, energyDrinkB []int) int {
    n := len(energyDrinkA)
    dp := make([][2]int, n)
    dp[0][0] = energyDrinkA[0]
    dp[0][1] = energyDrinkB[0]
    for i := 1; i < n; i++ {
        dp[i][0] = max(dp[i-1][0], dp[i-1][1]) + energyDrinkA[i]
        dp[i][1] = max(dp[i-1][0], dp[i-1][1]) + energyDrinkB[i]
    }
    return max(dp[n-1][0], dp[n-1][1])
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}