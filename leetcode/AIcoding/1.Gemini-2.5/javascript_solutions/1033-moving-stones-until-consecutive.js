var numMovesStones = function(a, b, c) {
    let arr = [a, b, c];
    arr.sort((x, y) => x - y);

    let x = arr[0];
    let y = arr[1];
    let z = arr[2];

    let minMoves;
    if (z - x === 2) {
        minMoves = 0;
    } else if (y - x <= 2 || z - y <= 2) {
        minMoves = 1;
    } else {
        minMoves = 2;
    }

    let maxMoves = (y - x - 1) + (z - y - 1);

    return [minMoves, maxMoves];
};