func spiralOrder(matrix [][]int) []int {
    if len(matrix) == 0 {
        return []int{}
    }
    m, n := len(matrix), len(matrix[0])
    res := make([]int, 0, m*n)
    top, bottom, left, right := 0, m-1, 0, n-1

    for top <= bottom && left <= right {
        for i := left; i <= right; i++ {
            res = append(res, matrix[top][i])
        }
        top++

        for i := top; i <= bottom; i++ {
            res = append(res, matrix[i][right])
        }
        right--

        if top <= bottom {
            for i := right; i >= left; i-- {
                res = append(res, matrix[bottom][i])
            }
            bottom--
        }

        if left <= right {
            for i := bottom; i >= top; i-- {
                res = append(res, matrix[i][left])
            }
            left++
        }
    }
    return res
}