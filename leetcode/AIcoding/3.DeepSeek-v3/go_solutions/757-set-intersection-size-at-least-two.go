func intersectionSizeTwo(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        if intervals[i][1] == intervals[j][1] {
            return intervals[i][0] > intervals[j][0]
        }
        return intervals[i][1] < intervals[j][1]
    })

    res := 0
    first, second := -1, -1

    for _, interval := range intervals {
        start, end := interval[0], interval[1]
        if start > second {
            res += 2
            first = end - 1
            second = end
        } else if start > first {
            res += 1
            first = second
            second = end
        }
    }

    return res
}