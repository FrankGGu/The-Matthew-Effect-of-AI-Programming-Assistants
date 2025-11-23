func kthSmallest(matrix [][]int, k int) int {
    n := len(matrix)
    left, right := matrix[0][0], matrix[n-1][n-1]

    for left < right {
        mid := left + (right - left) / 2
        count := 0
        j := n - 1
        for i := 0; i < n; i++ {
            for j >= 0 && matrix[i][j] > mid {
                j--
            }
            count += j + 1
        }
        if count < k {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}