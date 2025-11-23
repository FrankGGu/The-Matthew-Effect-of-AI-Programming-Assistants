func minimumMoves(s string) int {
    moves := 0
    i := 0
    for i < len(s) {
        if s[i] == 'X' {
            moves++
            i += 3
        } else {
            i++
        }
    }
    return moves
}