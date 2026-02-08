package main

func numberOfPaths(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    dp := make([][]map[int]int, m)
    for i := range dp {
        dp[i] = make(map[int]int)
    }
    dp[0][matrix[0]%k] = 1
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                continue
            }
            curr := matrix[i][j]
            temp := make(map[int]int)
            if i > 0 {
                for s, cnt := range dp[i-1] {
                    newSum := (s + curr) % k
                    temp[newSum] = (temp[newSum] + cnt) % (1e9+7)
                }
            }
            if j > 0 {
                for s, cnt := range dp[i][j-1] {
                    newSum := (s + curr) % k
                    temp[newSum] = (temp[newSum] + cnt) % (1e9+7)
                }
            }
            dp[i][j] = temp
        }
    }
    return dp[m-1][0] % (1e9+7)
}