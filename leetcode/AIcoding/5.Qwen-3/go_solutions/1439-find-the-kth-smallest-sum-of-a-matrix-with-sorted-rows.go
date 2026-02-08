package main

func kthSmallest(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    left, right := matrix[0][0], matrix[m-1][n-1]

    for left < right {
        mid := left + (right-left)/2
        count := 0
        for i := 0; i < m; i++ {
            j := 0
            for j < n && matrix[i][j] <= mid {
                j++
            }
            count += j
            if count >= k {
                break
            }
        }
        if count >= k {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}