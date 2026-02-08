var minMoves = function(target, maxDoubles) {
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
    moves += target - 1;
    return moves;
};