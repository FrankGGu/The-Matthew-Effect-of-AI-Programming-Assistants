package main

func kthSmallest(matrix [][]int, k int) int {
    n := len(matrix)
    left, right := matrix[0][0], matrix[n-1][n-1]

    for left < right {
        mid := left + (right-left)/2
        count := countLessEqual(matrix, mid)

        if count < k {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left
}

func countLessEqual(matrix [][]int, target int) int {
    n := len(matrix)
    count := 0
    row, col := 0, n-1

    for row < n && col >= 0 {
        if matrix[row][col] <= target {
            count += col + 1
            row++
        } else {
            col--
        }
    }

    return count
}