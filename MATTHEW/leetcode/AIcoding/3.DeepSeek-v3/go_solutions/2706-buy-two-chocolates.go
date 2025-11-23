func buyChoco(prices []int, money int) int {
    min1, min2 := math.MaxInt32, math.MaxInt32
    for _, price := range prices {
        if price < min1 {
            min2, min1 = min1, price
        } else if price < min2 {
            min2 = price
        }
    }
    total := min1 + min2
    if total <= money {
        return money - total
    }
    return money
}