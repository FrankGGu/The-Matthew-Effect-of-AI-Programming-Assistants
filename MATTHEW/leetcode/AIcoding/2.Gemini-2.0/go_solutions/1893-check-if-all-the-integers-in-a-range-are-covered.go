func isCovered(ranges [][]int, left int, right int) bool {
    covered := make([]bool, right-left+1)
    for _, r := range ranges {
        start := max(left, r[0])
        end := min(right, r[1])
        for i := start; i <= end; i++ {
            covered[i-left] = true
        }
    }
    for _, c := range covered {
        if !c {
            return false
        }
    }
    return true
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