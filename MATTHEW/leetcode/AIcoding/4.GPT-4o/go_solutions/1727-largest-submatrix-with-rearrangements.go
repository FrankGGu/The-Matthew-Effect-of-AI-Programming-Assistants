func largestSubmatrix(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    heights := make([][]int, rows)
    for i := range heights {
        heights[i] = make([]int, cols)
    }

    for j := 0; j < cols; j++ {
        for i := 0; i < rows; i++ {
            if matrix[i][j] == 1 {
                if i == 0 {
                    heights[i][j] = 1
                } else {
                    heights[i][j] = heights[i-1][j] + 1
                }
            }
        }
    }

    maxArea := 0
    for i := 0; i < rows; i++ {
        row := make([]int, cols)
        copy(row, heights[i])
        sort.Sort(sort.Reverse(sort.IntSlice(row)))
        for j := 0; j < cols; j++ {
            area := row[j] * (j + 1)
            if area > maxArea {
                maxArea = area
            }
        }
    }

    return maxArea
}