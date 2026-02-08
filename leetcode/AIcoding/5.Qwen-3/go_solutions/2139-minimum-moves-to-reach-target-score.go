package main

func minMoves(target int, maxDoubles int) int {
    moves := 0
    for target > 1 && maxDoubles > 0 {
        if target%2 == 0 {
            target /= 2
            maxDoubles--
        } else {
            target--
        }
        moves++
    }
    return moves + target - 1
}