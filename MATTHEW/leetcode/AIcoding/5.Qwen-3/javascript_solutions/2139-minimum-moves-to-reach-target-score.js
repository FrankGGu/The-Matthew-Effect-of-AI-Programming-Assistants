function minMoves(target, maxDoubles) {
    let moves = 0;
    while (target > 1 && maxDoubles > 0) {
        if (target % 2 === 0) {
            target /= 2;
            maxDoubles--;
        } else {
            target--;
        }
        moves++;
    }
    return moves + target - 1;
}