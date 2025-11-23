func minimumMoves(s string) int {
    moves := 0
    i := 0
    n := len(s)

    for i < n {
        if s[i] == 'X' {
            moves++
            i += 3
        } else {
            i++
        }
    }

    return moves
}