var minMoves = function(target, maxDoubles) {
    let moves = 0;
    while (target > 1) {
        if (maxDoubles === 0) {
            moves += target - 1;
            target = 1;
        } else if (target % 2 === 0 && maxDoubles > 0) {
            target /= 2;
            moves++;
            maxDoubles--;
        } else {
            target--;
            moves++;
        }
    }
    return moves;
};