func countBattleships(board [][]byte) int {
    if len(board) == 0 || len(board[0]) == 0 {
        return 0
    }

    count := 0
    for i := 0; i < len(board); i++ {
        for j := 0; j < len(board[0]); j++ {
            if board[i][j] == 'X' {
                if i == 0 || board[i-1][j] == '.' {
                    if j == 0 || board[i][j-1] == '.' {
                        count++
                    }
                }
            }
        }
    }
    return count
}