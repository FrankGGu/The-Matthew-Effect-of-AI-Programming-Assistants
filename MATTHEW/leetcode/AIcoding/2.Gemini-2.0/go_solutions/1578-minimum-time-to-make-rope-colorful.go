func minCost(colors string, neededTime []int) int {
    n := len(colors)
    ans := 0
    i := 0
    for i < n {
        j := i
        maxCost := 0
        totalCost := 0
        for j < n && colors[i] == colors[j] {
            maxCost = max(maxCost, neededTime[j])
            totalCost += neededTime[j]
            j++
        }
        ans += totalCost - maxCost
        i = j
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}