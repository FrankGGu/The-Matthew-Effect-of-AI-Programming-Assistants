package main

func maxTwoEvents(events [][]int) int {
    sort.Slice(events, func(i, j int) bool {
        return events[i][1] < events[j][1]
    })

    n := len(events)
    maxEvent := make([]int, n)
    maxVal := 0

    for i := n - 1; i >= 0; i-- {
        maxVal = max(maxVal, events[i][2])
        maxEvent[i] = maxVal
    }

    res := 0
    for i := 0; i < n; i++ {
        start, end, val := events[i][0], events[i][1], events[i][2]
        res = max(res, val)
        left, right := 0, i-1
        idx := -1
        for left <= right {
            mid := (left + right) / 2
            if events[mid][1] < start {
                idx = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        if idx != -1 {
            res = max(res, val+maxEvent[idx])
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}