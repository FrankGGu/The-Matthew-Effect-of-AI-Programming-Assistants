func largestSubmatrix(matrix [][]int) int {
    m, n := len(matrix), len(matrix[0])
    res := 0

    for i := 1; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == 1 {
                matrix[i][j] += matrix[i-1][j]
            }
        }
    }

    for i := 0; i < m; i++ {
        sort.Sort(sort.Reverse(sort.IntSlice(matrix[i])))
        for j := 0; j < n; j++ {
            res = max(res, matrix[i][j]*(j+1))
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