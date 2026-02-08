package main

func maxProfit(prices []int) int {
    if len(prices) < 2 {
        return 0
    }
    hold := make([]int, len(prices))
    notHold := make([]int, len(prices))
    hold[0] = -prices[0]
    for i := 1; i < len(prices); i++ {
        hold[i] = max(hold[i-1], notHold[i-1]-prices[i])
        notHold[i] = max(notHold[i-1], hold[i-1]+prices[i])
    }
    return notHold[len(prices)-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}