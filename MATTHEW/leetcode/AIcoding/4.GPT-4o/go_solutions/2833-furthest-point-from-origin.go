func furthestDistanceFromOrigin(moves string) int {
    left := 0
    right := 0
    for _, move := range moves {
        if move == 'L' {
            left++
        } else if move == 'R' {
            right++
        }
    }
    return left + right + len(moves) - left - right
}