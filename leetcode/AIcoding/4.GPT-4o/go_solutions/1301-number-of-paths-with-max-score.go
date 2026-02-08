func pathsWithMaxScore(board [][]int) []int {
    n, m := len(board), len(board[0])
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }

    mod := 1_000_000_007
    dp[n-1][m-1] = board[n-1][m-1]
    paths := make([][]int, n)
    for i := range paths {
        paths[i] = make([]int, m)
    }
    paths[n-1][m-1] = 1

    for i := n - 1; i >= 0; i-- {
        for j := m - 1; j >= 0; j-- {
            if board[i][j] == -1 {
                dp[i][j] = -1
                continue
            }
            if i < n-1 {
                if dp[i+1][j] != -1 {
                    if dp[i][j] < dp[i+1][j]+board[i][j] {
                        dp[i][j] = dp[i+1][j] + board[i][j]
                        paths[i][j] = paths[i+1][j]
                    } else if dp[i][j] == dp[i+1][j]+board[i][j] {
                        paths[i][j] = (paths[i][j] + paths[i+1][j]) % mod
                    }
                }
            }
            if j < m-1 {
                if dp[i][j+1] != -1 {
                    if dp[i][j] < dp[i][j+1]+board[i][j] {
                        dp[i][j] = dp[i][j+1] + board[i][j]
                        paths[i][j] = paths[i][j+1]
                    } else if dp[i][j] == dp[i][j+1]+board[i][j] {
                        paths[i][j] = (paths[i][j] + paths[i][j+1]) % mod
                    }
                }
            }
        }
    }

    if dp[0][0] == -1 {
        return []int{0, 0}
    }
    return []int{dp[0][0], paths[0][0]}
}