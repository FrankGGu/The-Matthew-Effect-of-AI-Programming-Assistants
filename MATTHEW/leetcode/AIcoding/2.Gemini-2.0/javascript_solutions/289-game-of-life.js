var gameOfLife = function(board) {
    const m = board.length;
    const n = board[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let liveNeighbors = 0;
            for (let x = Math.max(0, i - 1); x <= Math.min(m - 1, i + 1); x++) {
                for (let y = Math.max(0, j - 1); y <= Math.min(n - 1, j + 1); y++) {
                    if (x === i && y === j) continue;
                    if (Math.abs(board[x][y]) === 1) {
                        liveNeighbors++;
                    }
                }
            }

            if (board[i][j] === 1 && (liveNeighbors < 2 || liveNeighbors > 3)) {
                board[i][j] = -1; // 1 -> 0
            } else if (board[i][j] === 0 && liveNeighbors === 3) {
                board[i][j] = 2; // 0 -> 1
            }
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] === -1) {
                board[i][j] = 0;
            } else if (board[i][j] === 2) {
                board[i][j] = 1;
            }
        }
    }
};