var minMoves = function(target, maxDoubles) {
    let moves = 0;
    while (target > 1) {
        if (maxDoubles > 0) {
            if (target % 2 === 0) {
                target /= 2;
                maxDoubles--;
            } else {
                target--;
            }
        } else {
            target--;
        }
        moves++;
    }
    return moves;
};