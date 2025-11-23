func timeRequiredToBuy(tickets []int, k int) int {
    totalTime := 0
    for i := 0; i < len(tickets); i++ {
        if i <= k {
            totalTime += min(tickets[i], tickets[k])
        } else {
            totalTime += min(tickets[i], tickets[k]-1)
        }
    }
    return totalTime
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}