package main

import "math"

func maxProfit(prices []int) int {
    if len(prices) == 0 {
        return 0
    }

    t1Buy := math.MinInt32
    t1Sell := 0
    t2Buy := math.MinInt32
    t2Sell := 0

    for _, price := range prices {
        t2Sell = max(t2Sell, t2Buy+price)
        t2Buy = max(t2Buy, t1Sell-price)
        t1Sell = max(t1Sell, t1Buy+price)
        t1Buy = max(t1Buy, -price)
    }

    return t2Sell
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}