var numMovesStones = function(a, b, c) {
    let stones = [a, b, c];
    stones.sort((x, y) => x - y);
    let minMoves = 0;
    let maxMoves = stones[2] - stones[0] - 2;

    if (stones[0] + 1 === stones[1] && stones[1] + 1 === stones[2]) {
        minMoves = 0;
    } else if (stones[0] + 1 >= stones[1] || stones[1] + 1 >= stones[2]) {
        minMoves = 1;
    } else {
        minMoves = 2;
    }

    return [minMoves, maxMoves];
};