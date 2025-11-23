func minMoves(target int, maxDoubles int) int {
    moves := 0
    for target > 1 {
        if maxDoubles > 0 && target % 2 == 0 {
            target /= 2
            maxDoubles--
        } else {
            target--
        }
        moves++
    }
    return moves
}