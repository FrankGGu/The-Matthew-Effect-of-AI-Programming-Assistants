func minIncrements(n int, cost []int) int {
    res := 0
    for i := n / 2 - 1; i >= 0; i-- {
        left := 2*i + 1
        right := 2*i + 2
        maxChild := max(cost[left], cost[right])
        res += maxChild - min(cost[left], cost[right])
        cost[i] += maxChild
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}