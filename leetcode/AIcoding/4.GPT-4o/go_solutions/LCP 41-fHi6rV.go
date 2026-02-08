func flipChess(chessboard []string) int {
    rows, cols := len(chessboard), len(chessboard[0])
    maxFlips := 0
    directions := [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if chessboard[r][c] == '.' {
                flips := 0
                for _, dir := range directions {
                    nr, nc := r + dir[0], c + dir[1]
                    if nr >= 0 && nr < rows && nc >= 0 && nc < cols && chessboard[nr][nc] == 'X' {
                        flips++
                    }
                }
                maxFlips = max(maxFlips, flips)
            }
        }
    }

    return maxFlips
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}