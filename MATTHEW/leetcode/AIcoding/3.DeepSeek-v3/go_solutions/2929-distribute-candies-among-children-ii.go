func distributeCandies(n int64, limit int64) int64 {
    var res int64 = 0
    for a := int64(0); a <= min(n, limit); a++ {
        remaining := n - a
        lower := max(0, remaining - limit)
        upper := min(limit, remaining)
        if lower <= upper {
            res += upper - lower + 1
        }
    }
    return res
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}