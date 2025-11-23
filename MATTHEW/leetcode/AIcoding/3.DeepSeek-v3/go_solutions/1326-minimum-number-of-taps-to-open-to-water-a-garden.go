func minTaps(n int, ranges []int) int {
    intervals := make([][]int, n+1)
    for i := 0; i <= n; i++ {
        left := max(0, i-ranges[i])
        right := min(n, i+ranges[i])
        intervals[i] = []int{left, right}
    }

    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    res := 0
    currentEnd := 0
    nextEnd := 0
    i := 0

    for currentEnd < n {
        for i <= n && intervals[i][0] <= currentEnd {
            nextEnd = max(nextEnd, intervals[i][1])
            i++
        }
        if nextEnd == currentEnd {
            return -1
        }
        currentEnd = nextEnd
        res++
    }

    return res
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