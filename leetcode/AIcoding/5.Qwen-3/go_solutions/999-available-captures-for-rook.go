package main

func numRookMoves(board [][]byte) int {
    for i := 0; i < 8; i++ {
        for j := 0; j < 8; j++ {
            if board[i][j] == 'R' {
                count := 0
                // Up
                for k := i - 1; k >= 0; k-- {
                    if board[k][j] != '.' {
                        count++
                        break
                    }
                }
                // Down
                for k := i + 1; k < 8; k++ {
                    if board[k][j] != '.' {
                        count++
                        break
                    }
                }
                // Left
                for k := j - 1; k >= 0; k-- {
                    if board[i][k] != '.' {
                        count++
                        break
                    }
                }
                // Right
                for k := j + 1; k < 8; k++ {
                    if board[i][k] != '.' {
                        count++
                        break
                    }
                }
                return count
            }
        }
    }
    return 0
}