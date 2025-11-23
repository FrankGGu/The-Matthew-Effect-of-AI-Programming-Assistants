func maxMovesToKillAllPawns(board [][]int) int {
    m, n := len(board), len(board[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    maxMoves := 0

    for j := n - 2; j >= 0; j-- {
        for i := 0; i < m; i++ {
            maxNext := 0
            for _, di := range []int{-1, 0, 1} {
                ni := i + di
                if ni >= 0 && ni < m && j+1 < n {
                    if board[i][j] < board[ni][j+1] {
                        if dp[ni][j+1] > maxNext {
                            maxNext = dp[ni][j+1]
                        }
                    }
                }
            }
            dp[i][j] = maxNext + 1
            if dp[i][j] > maxMoves {
                maxMoves = dp[i][j]
            }
        }
    }

    return maxMoves
}