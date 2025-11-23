func findRightInterval(intervals [][]int) []int {
    n := len(intervals)
    result := make([]int, n)
    starts := make([][2]int, n)

    for i, interval := range intervals {
        starts[i] = [2]int{interval[0], i}
    }

    sort.Slice(starts, func(i, j int) bool {
        return starts[i][0] < starts[j][0]
    })

    for i, interval := range intervals {
        left, right := 0, n
        for left < right {
            mid := (left + right) / 2
            if starts[mid][0] < interval[1] {
                left = mid + 1
            } else {
                right = mid
            }
        }
        if left < n {
            result[i] = starts[left][1]
        } else {
            result[i] = -1
        }
    }

    return result
}