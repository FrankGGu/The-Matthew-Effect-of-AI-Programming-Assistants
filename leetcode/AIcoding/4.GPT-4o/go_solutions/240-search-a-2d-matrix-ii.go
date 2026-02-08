func searchMatrix(matrix [][]int, target int) bool {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return false
    }

    row, col := len(matrix), len(matrix[0])
    r, c := 0, col-1

    for r < row && c >= 0 {
        if matrix[r][c] == target {
            return true
        } else if matrix[r][c] > target {
            c--
        } else {
            r++
        }
    }

    return false
}