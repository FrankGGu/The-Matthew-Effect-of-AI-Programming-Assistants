var flipChess = function(chessboard) {
    const m = chessboard.length;
    const n = chessboard[0].length;
    const dirs = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    let maxCount = 0;

    const bfs = (i, j, board) => {
        let count = 0;
        const queue = [[i, j]];
        const tempBoard = board.map(row => [...row]);
        tempBoard[i][j] = 'X';

        while (queue.length > 0) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of dirs) {
                let nx = x + dx;
                let ny = y + dy;
                const path = [];
                while (nx >= 0 && nx < m && ny >= 0 && ny < n && tempBoard[nx][ny] === 'O') {
                    path.push([nx, ny]);
                    nx += dx;
                    ny += dy;
                }
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && tempBoard[nx][ny] === 'X' && path.length > 0) {
                    for (const [px, py] of path) {
                        tempBoard[px][py] = 'X';
                        queue.push([px, py]);
                        count++;
                    }
                }
            }
        }
        return count;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (chessboard[i][j] === '.') {
                const cnt = bfs(i, j, chessboard);
                if (cnt > maxCount) {
                    maxCount = cnt;
                }
            }
        }
    }
    return maxCount;
};