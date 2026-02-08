var breakDownMoves = function(moves) {
    let count = 0;
    let i = 0;
    while (i < moves.length) {
        if (i + 1 < moves.length && moves[i] !== moves[i + 1]) {
            count++;
            i += 2;
        } else {
            i++;
        }
    }
    return count;
};