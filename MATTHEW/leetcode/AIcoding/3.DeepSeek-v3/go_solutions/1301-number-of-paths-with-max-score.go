func pathsWithMaxScore(board []string) []int {
    n := len(board)
    mod := int(1e9 + 7)

    dp := make([][]int, n)
    count := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        count[i] = make([]int, n)
    }

    count[n-1][n-1] = 1

    for i := n - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if board[i][j] == 'X' {
                continue
            }
            if i == n-1 && j == n-1 {
                continue
            }

            maxVal := 0
            cnt := 0

            if i+1 < n {
                if dp[i+1][j] > maxVal {
                    maxVal = dp[i+1][j]
                    cnt = count[i+1][j]
                } else if dp[i+1][j] == maxVal {
                    cnt += count[i+1][j]
                }
            }

            if j+1 < n {
                if dp[i][j+1] > maxVal {
                    maxVal = dp[i][j+1]
                    cnt = count[i][j+1]
                } else if dp[i][j+1] == maxVal {
                    cnt += count[i][j+1]
                }
            }

            if i+1 < n && j+1 < n {
                if dp[i+1][j+1] > maxVal {
                    maxVal = dp[i+1][j+1]
                    cnt = count[i+1][j+1]
                } else if dp[i+1][j+1] == maxVal {
                    cnt += count[i+1][j+1]
                }
            }

            if cnt > 0 {
                val := 0
                if board[i][j] != 'E' && board[i][j] != 'S' {
                    val = int(board[i][j] - '0')
                }
                dp[i][j] = maxVal + val
                count[i][j] = cnt % mod
            }
        }
    }

    if count[0][0] == 0 {
        return []int{0, 0}
    }
    return []int{dp[0][0], count[0][0]}
}