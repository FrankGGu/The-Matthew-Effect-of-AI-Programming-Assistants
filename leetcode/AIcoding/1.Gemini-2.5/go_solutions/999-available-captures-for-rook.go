func numRookCaptures(board [][]byte) int {
    rookRow, rookCol := -1, -1
    for r := 0; r < 8; r++ {
        for c := 0; c < 8; c++ {
            if board[r][c] == 'R' {
                rookRow = r
                rookCol = c
                break
            }
        }
        if rookRow != -1 {
            break
        }
    }

    captures := 0
    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}} // right, left, down, up

    for _, dir := range directions {
        dr, dc := dir[0], dir[1]
        for step := 1; ; step++ {
            r, c := rookRow+step*dr, rookCol+step*dc

            if r < 0 || r >= 8 || c < 0 || c >= 8 {
                break // Out of bounds
            }

            if board[r][c] == 'p' {
                captures++
                break // Captured a pawn, stop in this direction
            } else if board[r][c] == 'B' {
                break // Blocked by a bishop, stop in this direction
            }
            // If it's an empty square '.', continue in this direction
        }
    }

    return captures
}