func equalSubstring(s string, t string, maxCost int) int {
    n := len(s)
    cost := make([]int, n)
    for i := 0; i < n; i++ {
        cost[i] = abs(int(s[i]) - int(t[i]))
    }

    left, currentCost, maxLen := 0, 0, 0
    for right := 0; right < n; right++ {
        currentCost += cost[right]
        for currentCost > maxCost {
            currentCost -= cost[left]
            left++
        }
        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
    }
    return maxLen
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}