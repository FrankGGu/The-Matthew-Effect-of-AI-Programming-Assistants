package main

func minCostToEqualizeFruits(fruits []int, cost []int) int {
    n := len(fruits)
    totalFruits := 0
    for _, f := range fruits {
        totalFruits += f
    }
    res := 0
    for i := 0; i < n; i++ {
        res += (fruits[i] * cost[i]) % 1000000007
    }
    return res % 1000000007
}