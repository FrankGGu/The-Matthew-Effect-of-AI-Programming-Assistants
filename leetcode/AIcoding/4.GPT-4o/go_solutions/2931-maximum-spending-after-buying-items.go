func maximumSpending(prices []int, n int, money int) int {
    sort.Ints(prices)
    maxSpending := 0
    cnt := 0

    for _, price := range prices {
        if cnt < n && money >= price {
            maxSpending += price
            money -= price
            cnt++
        } else {
            break
        }
    }
    return maxSpending
}