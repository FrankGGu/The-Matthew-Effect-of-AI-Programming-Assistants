var maxKilledPawns = function(pawns, knights) {
    pawns.sort((a, b) => a - b);
    knights.sort((a, b) => a - b);
    let killed = 0;
    let knightIndex = 0;
    for (let pawn of pawns) {
        while (knightIndex < knights.length && knights[knightIndex] < pawn - 1) {
            knightIndex++;
        }
        if (knightIndex < knights.length && (knights[knightIndex] === pawn - 1 || knights[knightIndex] === pawn + 1)) {
            killed++;
            knightIndex++;
        }
    }
    return killed;
};