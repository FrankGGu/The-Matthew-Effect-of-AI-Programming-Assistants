func minMoves(target int, maxDoubles int) int {
    moves := 0
    for target > 1 && maxDoubles > 0 {
        if target%2 == 0 {
            target /= 2
            maxDoubles--
            moves++
        } else {
            target--
            moves++
        }
    }
    moves += target - 1
    return moves
}