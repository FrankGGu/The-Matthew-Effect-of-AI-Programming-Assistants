func numEquivDominoPairs(dominoes [][]int) int {
    count := make(map[[2]int]int)
    pairs := 0

    for _, d := range dominoes {
        key := [2]int{min(d[0], d[1]), max(d[0], d[1])}
        pairs += count[key]
        count[key]++
    }

    return pairs
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