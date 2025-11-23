func maxItems(prices []int, k int) int {
    sort.Ints(prices)
    count := 0
    for _, price := range prices {
        if k >= price {
            k -= price
            count++
        } else {
            break
        }
    }
    return count
}