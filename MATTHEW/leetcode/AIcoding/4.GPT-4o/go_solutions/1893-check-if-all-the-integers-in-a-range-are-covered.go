func isCovered(ranges [][]int, left int, right int) bool {
    covered := make([]bool, right-left+1)

    for _, r := range ranges {
        for i := max(r[0], left); i <= min(r[1], right); i++ {
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