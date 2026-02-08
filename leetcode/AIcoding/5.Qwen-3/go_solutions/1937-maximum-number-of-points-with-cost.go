package main

func maxPoints(points [][]int) int {
    rows := len(points)
    cols := len(points[0])

    prev := make([]int, cols)
    copy(prev, points[0])

    for i := 1; i < rows; i++ {
        curr := make([]int, cols)
        left := make([]int, cols)
        right := make([]int, cols)

        left[0] = prev[0]
        for j := 1; j < cols; j++ {
            left[j] = max(left[j-1]-1, prev[j])
        }

        right[cols-1] = prev[cols-1]
        for j := cols - 2; j >= 0; j-- {
            right[j] = max(right[j+1]-1, prev[j])
        }

        for j := 0; j < cols; j++ {
            curr[j] = points[i][j] + max(left[j], right[j])
        }

        prev = curr
    }

    return prev[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}