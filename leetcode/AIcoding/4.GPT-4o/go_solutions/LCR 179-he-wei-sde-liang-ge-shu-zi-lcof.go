func twoSum(prices []int, target int) []int {
    m := make(map[int]int)
    for i, price := range prices {
        if j, ok := m[target-price]; ok {
            return []int{j, i}
        }
        m[price] = i
    }
    return nil
}