var numRookCaptures = function(board) {
    let count = 0;
    let directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    let rookPosition;

    for (let i = 0; i < 8; i++) {
        for (let j = 0; j < 8; j++) {
            if (board[i][j] === 'R') {
                rookPosition = [i, j];
                break;
            }
        }
    }

    for (let [dx, dy] of directions) {
        let x = rookPosition[0];
        let y = rookPosition[1];

        while (true) {
            x += dx;
            y += dy;
            if (x < 0 || x >= 8 || y < 0 || y >= 8) break;
            if (board[x][y] === 'B') break;
            if (board[x][y] === 'p') {
                count++;
                break;
            }
        }
    }

    return count;
};