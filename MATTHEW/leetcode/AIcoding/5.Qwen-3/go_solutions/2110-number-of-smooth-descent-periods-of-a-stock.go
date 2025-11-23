package main

func getDescentPeriods(prices []int) int64 {
    if len(prices) == 0 {
        return 0
    }
    count := int64(1)
    prev := prices[0]
    streak := int64(1)
    for i := 1; i < len(prices); i++ {
        if prev - prices[i] == 0 {
            streak++
        } else {
            streak = 1
        }
        count += streak
        prev = prices[i]
    }
    return count
}