var queensAttacktheKing = function(queens, king) {
    const result = [];
    const queenSet = new Set();
    for (const queen of queens) {
        queenSet.add(queen[0] + ',' + queen[1]);
    }

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],         [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    for (const dir of directions) {
        let x = king[0] + dir[0];
        let y = king[1] + dir[1];

        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (queenSet.has(x + ',' + y)) {
                result.push([x, y]);
                break;
            }
            x += dir[0];
            y += dir[1];
        }
    }

    return result;
};