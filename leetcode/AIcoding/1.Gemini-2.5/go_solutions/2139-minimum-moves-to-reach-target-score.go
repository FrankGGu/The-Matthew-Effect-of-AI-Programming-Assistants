func minMoves(target int, maxDoubles int) int {
    moves := 0
    for target > 1 {
        if maxDoubles == 0 {
            // If no more doubles are allowed, we can only decrement.
            // It takes (target - 1) decrements to reach 1.
            moves +=