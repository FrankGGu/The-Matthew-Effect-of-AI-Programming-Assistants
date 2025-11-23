func twoSum(prices []int, target int) []int {
    priceMap := make(map[int]int)
    for i, price := range prices {
        complement := target - price
        if idx, found := priceMap[complement]; found {
            return []int{idx, i}
        }
        priceMap[price] = i
    }
    return nil // Should not reach here based on problem constraints (exactly one solution)
}