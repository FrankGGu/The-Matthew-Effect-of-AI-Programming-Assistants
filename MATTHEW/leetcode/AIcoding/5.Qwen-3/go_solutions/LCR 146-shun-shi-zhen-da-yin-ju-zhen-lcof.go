package main

func spiralOrder(matrix [][]int) []int {
    if len(matrix) == 0 {
        return []int{}
    }
    result := make([]int, 0)
    top := 0
    bottom := len(matrix) - 1
    left := 0
    right := len(matrix[0]) - 1

    for top <= bottom && left <= right {
        for i := left; i <= right; i++ {
            result = append(result, matrix[top][i])
        }
        top++

        for i := top; i <= bottom; i++ {
            result = append(result, matrix[i][right])
        }
        right--

        if top <= bottom {
            for i := right; i >= left; i-- {
                result = append(result, matrix[bottom][i])
            }
            bottom--
        }

        if left <= right {
            for i := bottom; i >= top; i-- {
                result = append(result, matrix[i][left])
            }
            left++
        }
    }
    return result
}