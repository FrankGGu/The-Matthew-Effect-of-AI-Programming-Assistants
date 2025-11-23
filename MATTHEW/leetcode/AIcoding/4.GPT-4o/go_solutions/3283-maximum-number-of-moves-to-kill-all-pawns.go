func getMaxMoves(pawns []string) int {
    rows := len(pawns)
    cols := len(pawns[0])
    moves := 0

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if pawns[i][j] == 'P' {
                moves += i + j
            }
        }
    }

    return moves
}