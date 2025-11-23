func findMinMoves(machines []int) int {
    total := 0
    maxSize := 0
    n := len(machines)
    for _, m := range machines {
        total += m
        maxSize = max(maxSize, m)
    }
    if total%n != 0 {
        return -1
    }
    target := total / n
    maxMoves := 0
    current := 0
    for _, m := range machines {
        diff := m - target
        current += diff
        maxMoves = max(maxMoves, abs(current), diff)
    }
    return maxMoves
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}