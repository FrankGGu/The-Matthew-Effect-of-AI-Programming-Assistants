package main

func finalPrices(prices []int) []int {
    n := len(prices)
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = prices[i]
        for j := i + 1; j < n; j++ {
            if prices[j] <= prices[i] {
                result[i] -= prices[j]
                break
            }
        }
    }
    return result
}