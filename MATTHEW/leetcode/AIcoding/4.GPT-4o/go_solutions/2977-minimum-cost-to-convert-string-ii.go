func minimumCost(s1 string, s2 string, cost int) int {
    if len(s1) != len(s2) {
        return -1
    }

    n := len(s1)
    totalCost := 0
    countA, countB := 0, 0

    for i := 0; i < n; i++ {
        if s1[i] != s2[i] {
            if s1[i] == 'a' {
                countA++
            } else {
                countB++
            }
        }
    }

    totalCost = min(countA, countB) * cost
    totalCost += (max(countA, countB) - min(countA, countB)) * (cost + 1)

    return totalCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}