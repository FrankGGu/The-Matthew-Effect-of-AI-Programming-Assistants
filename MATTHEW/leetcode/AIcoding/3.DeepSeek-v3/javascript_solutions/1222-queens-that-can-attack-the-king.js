var queensAttacktheKing = function(queens, king) {
    const board = Array(8).fill().map(() => Array(8).fill(0));
    const result = [];

    for (const [x, y] of queens) {
        board[x][y] = 1;
    }

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],          [0, 1],
        [1, -1],  [1, 0], [1, 1]
    ];

    for (const [dx, dy] of directions) {
        let x = king[0] + dx;
        let y = king[1] + dy;

        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (board[x][y] === 1) {
                result.push([x, y]);
                break;
            }
            x += dx;
            y += dy;
        }
    }

    return result;
};