var numberOfMoves = function(pawns) {
    let count = 0;
    for (let i = 0; i < pawns.length; i++) {
        if (pawns[i] === 'A') {
            count += 1;
        }
    }
    return count;
};