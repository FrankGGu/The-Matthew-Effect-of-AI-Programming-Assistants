package main

func findPeakElement(matrix [][]int) int {
    rows, cols := len(matrix), len(matrix[0])
    left, right := 0, cols-1
    for left <= right {
        midCol := left + (right-left)/2
        maxRow := 0
        for i := 1; i < rows; i++ {
            if matrix[i][midCol] > matrix[maxRow][midCol] {
                maxRow = i
            }
        }
        if midCol == 0 {
            if matrix[maxRow][midCol] > matrix[maxRow][midCol+1] {
                return maxRow*cols + midCol
            }
        } else if midCol == cols-1 {
            if matrix[maxRow][midCol] > matrix[maxRow][midCol-1] {
                return maxRow*cols + midCol
            }
        } else {
            if matrix[maxRow][midCol] > matrix[maxRow][midCol-1] && matrix[maxRow][midCol] > matrix[maxRow][midCol+1] {
                return maxRow*cols + midCol
            } else if matrix[maxRow][midCol] < matrix[maxRow][midCol+1] {
                left = midCol + 1
            } else {
                right = midCol - 1
            }
        }
    }
    return -1
}