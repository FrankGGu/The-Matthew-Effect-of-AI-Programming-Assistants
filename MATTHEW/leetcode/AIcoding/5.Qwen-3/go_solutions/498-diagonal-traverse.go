package main

func findDiagonalOrder(matrix [][]int) []int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return []int{}
    }

    rows, cols := len(matrix), len(matrix[0])
    result := make([]int, 0, rows*cols)
    row, col := 0, 0

    for row < rows && col < cols {
        result = append(result, matrix[row][col])

        if (row+col)%2 == 0 {
            if col == cols-1 {
                row++
            } else if row == 0 {
                col++
            } else {
                row--
                col++
            }
        } else {
            if row == rows-1 {
                col++
            } else if col == 0 {
                row++
            } else {
                row++
                col--
            }
        }
    }

    return result
}