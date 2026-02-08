func minMoves(target int, maxDoubles int) int {
    moves := 0
    for target > 1 {
        if maxDoubles == 0 {
            moves += target - 1
            break
        }
        if target % 2 == 1 {
            target--
            moves++
        } else {
            target /= 2
            moves++
            maxDoubles--
        }
    }
    return moves
}