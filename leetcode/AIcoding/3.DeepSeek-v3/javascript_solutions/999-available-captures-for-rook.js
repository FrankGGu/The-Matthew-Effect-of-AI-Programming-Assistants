var numRookCaptures = function(board) {
    let rookX, rookY;
    for (let i = 0; i < 8; i++) {
        for (let j = 0; j < 8; j++) {
            if (board[i][j] === 'R') {
                rookX = i;
                rookY = j;
                break;
            }
        }
        if (rookX !== undefined) break;
    }

    let count = 0;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (const [dx, dy] of directions) {
        let x = rookX + dx;
        let y = rookY + dy;
        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (board[x][y] === 'p') {
                count++;
                break;
            }
            if (board[x][y] !== '.') break;
            x += dx;
            y += dy;
        }
    }

    return count;
};