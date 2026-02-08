func equalSubstring(s string, t string, maxCost int) int {
    n := len(s)
    costs := make([]int, n)
    for i := 0; i < n; i++ {
        costs[i] = int(abs(int(s[i]) - int(t[i])))
    }

    left, right, totalCost, maxLength := 0, 0, 0, 0

    for right < n {
        totalCost += costs[right]
        for totalCost > maxCost {
            totalCost -= costs[left]
            left++
        }
        maxLength = max(maxLength, right-left+1)
        right++
    }

    return maxLength
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}