func maxValueSum(matrix [][]int) int {
    n, m := len(matrix), len(matrix[0])
    maxRowSum := make([]int, n)
    maxColSum := make([]int, m)

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            maxRowSum[i] = max(maxRowSum[i], matrix[i][j])
            maxColSum[j] = max(maxColSum[j], matrix[i][j])
        }
    }

    maxSum := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            sum := maxRowSum[i] + maxColSum[j] - matrix[i][j]
            maxSum = max(maxSum, sum)
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}