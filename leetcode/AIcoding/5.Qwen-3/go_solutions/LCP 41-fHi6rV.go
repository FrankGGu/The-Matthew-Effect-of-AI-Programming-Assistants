package main

func flipChess(board []string) int {
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}}
    rows, cols := len(board), len(board[0])
    maxFlips := 0

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if board[i][j] == ' ' {
                continue
            }
            for _, dir := range directions {
                x, y := i+dir[0], j+dir[1]
                count := 0
                for x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] == 'o' {
                    x += dir[0]
                    y += dir[1]
                    count++
                }
                if x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] == ' ' && count > 0 {
                    maxFlips = max(maxFlips, count)
                }
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