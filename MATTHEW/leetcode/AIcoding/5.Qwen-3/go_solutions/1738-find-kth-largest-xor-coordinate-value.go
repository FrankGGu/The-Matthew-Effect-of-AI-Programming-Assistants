package main

func kthLargestValue(matrix [][]int, k int) int {
    m := len(matrix)
    n := len(matrix[0])
    maxHeap := make([]int, 0)

    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                dp[i][j] = matrix[i][j]
            } else if i == 0 {
                dp[i][j] = dp[i][j-1] ^ matrix[i][j]
            } else if j == 0 {
                dp[i][j] = dp[i-1][j] ^ matrix[i][j]
            } else {
                dp[i][j] = dp[i-1][j] ^ dp[i][j-1] ^ matrix[i][j]
            }
            maxHeap = append(maxHeap, dp[i][j])
        }
    }

    sort.Ints(maxHeap)
    return maxHeap[len(maxHeap)-k]
}