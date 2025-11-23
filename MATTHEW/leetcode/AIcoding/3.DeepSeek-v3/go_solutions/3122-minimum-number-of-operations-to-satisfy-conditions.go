func minimumOperations(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    freq := make([][]int, n)
    for i := range freq {
        freq[i] = make([]int, 10)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            freq[j][grid[i][j]]++
        }
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, 10)
    }

    for num := 0; num < 10; num++ {
        dp[0][num] = m - freq[0][num]
    }

    for j := 1; j < n; j++ {
        for num := 0; num < 10; num++ {
            minVal := math.MaxInt32
            for prevNum := 0; prevNum < 10; prevNum++ {
                if prevNum != num {
                    if dp[j-1][prevNum] < minVal {
                        minVal = dp[j-1][prevNum]
                    }
                }
            }
            dp[j][num] = minVal + (m - freq[j][num])
        }
    }

    res := math.MaxInt32
    for num := 0; num < 10; num++ {
        if dp[n-1][num] < res {
            res = dp[n-1][num]
        }
    }
    return res
}