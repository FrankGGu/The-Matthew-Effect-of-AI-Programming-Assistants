func findMinMoves(machines []int) int {
    total := 0
    for _, v := range machines {
        total += v
    }
    n := len(machines)
    if total%n != 0 {
        return -1
    }
    avg := total / n
    res := 0
    sum := 0
    for _, num := range machines {
        diff := num - avg
        sum += diff
        res = max(res, max(abs(sum), diff))
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}