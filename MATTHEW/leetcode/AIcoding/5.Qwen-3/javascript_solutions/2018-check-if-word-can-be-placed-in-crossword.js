var placeWordInCrossword = function(board, word) {
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const n = board.length;
    const m = board[0].length;
    const wordLen = word.length;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            for (const [dx, dy] of directions) {
                let x = i + dx;
                let y = j + dy;
                let k = 0;
                while (x >= 0 && x < n && y >= 0 && y < m && (board[x][y] === word[k] || board[x][y] === '#')) {
                    if (board[x][y] !== '#') {
                        k++;
                    }
                    x += dx;
                    y += dy;
                }
                if (k === wordLen) {
                    return true;
                }
            }
        }
    }
    return false;
};