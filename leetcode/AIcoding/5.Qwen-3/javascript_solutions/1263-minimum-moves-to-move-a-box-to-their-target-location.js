function minMoves(s) {
    let moves = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'B') {
            moves++;
            i += 2;
        }
    }
    return moves;
}