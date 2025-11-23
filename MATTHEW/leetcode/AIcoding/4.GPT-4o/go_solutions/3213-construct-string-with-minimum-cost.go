func minimumCost(s string) int {
    n := len(s)
    cost := make([]int, n)
    cost[0] = int(s[0] - 'a' + 1)

    for i := 1; i < n; i++ {
        cost[i] = cost[i-1] + int(s[i]-'a'+1)
    }

    minCost := cost[n-1]
    for i := 1; i < n; i++ {
        if s[i] != s[i-1] {
            minCost = min(minCost, cost[i-1]+cost[n-1]-cost[i])
        }
    }

    return minCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}