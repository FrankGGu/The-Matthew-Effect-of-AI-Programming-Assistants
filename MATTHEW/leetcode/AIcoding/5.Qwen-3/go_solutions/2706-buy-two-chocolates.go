package main

func buyChocolates(prices []int, money int) int {
    if len(prices) < 2 {
        return money
    }

    min1 := math.MaxInt
    min2 := math.MaxInt

    for _, price := range prices {
        if price < min1 {
            min2 = min1
            min1 = price
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