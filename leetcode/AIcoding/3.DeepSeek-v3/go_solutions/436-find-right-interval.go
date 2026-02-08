func findRightInterval(intervals [][]int) []int {
    n := len(intervals)
    starts := make([][2]int, n)
    for i, interval := range intervals {
        starts[i] = [2]int{interval[0], i}
    }
    sort.Slice(starts, func(i, j int) bool {
        return starts[i][0] < starts[j][0]
    })

    res := make([]int, n)
    for i, interval := range intervals {
        end := interval[1]
        left, right := 0, n
        for left < right {
            mid := left + (right - left) / 2
            if starts[mid][0] < end {
                left = mid + 1
            } else {
                right = mid
            }
        }
        if left < n {
            res[i] = starts[left][1]
        } else {
            res[i] = -1
        }
    }
    return res
}