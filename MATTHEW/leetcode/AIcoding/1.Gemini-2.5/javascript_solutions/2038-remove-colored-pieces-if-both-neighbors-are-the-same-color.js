var winnerOfGame = function(colors) {
    let aliceMoves = 0;
    let bobMoves = 0;

    for (let i = 1; i < colors.length - 1; i++) {
        if (colors[i - 1] === 'A' && colors[i] === 'A' && colors[i + 1] === 'A') {
            aliceMoves++;
        } else if (colors[i - 1] === 'B' && colors[i] === 'B' && colors[i + 1] === 'B') {
            bobMoves++;
        }
    }

    return aliceMoves > bobMoves;
};