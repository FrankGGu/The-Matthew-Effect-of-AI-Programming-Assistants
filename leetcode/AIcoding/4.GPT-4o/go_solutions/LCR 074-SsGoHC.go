func merge(intervals [][]int) [][]int {
    if len(intervals) == 0 {
        return [][]int{}
    }

    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    merged := [][]int{intervals[0]}

    for _, interval := range intervals[1:] {
        last := merged[len(merged)-1]
        if interval[0] <= last[1] {
            last[1] = max(last[1], interval[1])
        } else {
            merged = append(merged, interval)
        }
    }

    return merged
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}