package main

func maxSpending(sheep [][]int) int {
    m, n := len(sheep), len(sheep[0])
    prices := make([]int, 0, m*n)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            prices = append(prices, sheep[i][j])
        }
    }
    sort.Ints(prices)
    total := 0
    for i := 0; i < len(prices); i++ {
        total += prices[i] * (i + 1)
    }
    return total
}