func minimumMoves(s string) int {
    moves := 0
    n := len(s)
    i := 0
    for i < n {
        if s[i] == 'X' {
            moves++
            i += 3 // Cover s[i], s[i+1], s[i+2]
        } else {
            i++ // Move to the next character
        }
    }
    return moves
}