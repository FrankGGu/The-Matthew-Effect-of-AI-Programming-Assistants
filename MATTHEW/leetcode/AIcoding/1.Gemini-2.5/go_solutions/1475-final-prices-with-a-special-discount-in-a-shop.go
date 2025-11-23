func finalPrices(prices []int) []int {
    n := len(prices)
    result := make([]int, n)

    for i := 0; i < n; i++ {
        discount := 0
        for j := i + 1; j < n; j++ {
            if prices[j] <= prices[i] {
                discount = prices[j]
                break
            }
        }
        result[i] = prices[i] - discount
    }

    return result
}