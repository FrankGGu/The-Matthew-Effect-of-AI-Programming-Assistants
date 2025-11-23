func buyChoco(prices []int, money int) int {
    sort.Ints(prices)
    if len(prices) < 2 {
        return money
    }
    totalCost := prices[0] + prices[1]
    if totalCost > money {
        return money
    }
    return money - totalCost
}