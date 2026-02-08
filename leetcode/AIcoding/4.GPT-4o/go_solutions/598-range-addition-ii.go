func maxCount(m int, n int, ops [][]int) int {
    if len(ops) == 0 {
        return m * n
    }

    minRow, minCol := m, n
    for _, op := range ops {
        minRow = min(minRow, op[0])
        minCol = min(minCol, op[1])
    }

    return minRow * minCol
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}