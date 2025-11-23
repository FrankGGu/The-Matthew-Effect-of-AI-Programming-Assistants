var minimumMoves = function(s) {
    let moves = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'X') {
            moves++;
            i += 2; // Skip the next two positions
        }
    }
    return moves;
};