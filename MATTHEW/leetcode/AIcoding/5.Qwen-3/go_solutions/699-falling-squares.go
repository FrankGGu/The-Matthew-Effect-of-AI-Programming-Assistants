package main

func fallingSquares(partitions [][]int) [][]int {
    res := [][]int{}
    intervals := [][]int{}
    heights := []int{}

    for _, p := range partitions {
        left, right, height := p[0], p[1], p[2]
        start, end := left, right
        base := 0

        for i := 0; i < len(intervals); i++ {
            if intervals[i][0] < end && intervals[i][1] > start {
                base = max(base, heights[i])
            }
        }

        newHeight := base + height
        intervals = append(intervals, []int{start, end})
        heights = append(heights, newHeight)
        res = append(res, []int{start, newHeight})
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}