func findDiagonalOrder(matrix [][]int) []int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return []int{}
    }

    rows, cols := len(matrix), len(matrix[0])
    result := make([]int, 0, rows*cols)
    dir := 1 // 1 for upward, -1 for downward
    r, c := 0, 0

    for len(result) < rows*cols {
        result = append(result, matrix[r][c])
        if dir == 1 {
            if c == cols-1 {
                r++
                dir = -1
            } else if r == 0 {
                c++
                dir = -1
            } else {
                r--
                c++
            }
        } else {
            if r == rows-1 {
                c++
                dir = 1
            } else if c == 0 {
                r++
                dir = 1
            } else {
                r++
                c--
            }
        }
    }

    return result
}