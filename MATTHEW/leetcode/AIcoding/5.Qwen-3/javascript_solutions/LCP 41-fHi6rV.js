function flipChess(board, r0, c0) {
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]];
    const m = board.length;
    const n = board[0].length;
    const queue = [[r0, c0]];
    const visited = new Set([`${r0},${c0}`]);
    let count = 0;

    while (queue.length > 0) {
        const [r, c] = queue.shift();
        for (const [dr, dc] of directions) {
            let x = r + dr;
            let y = c + dc;
            const path = [];
            while (x >= 0 && x < m && y >= 0 && y < n && board[x][y] === 'o') {
                path.push([x, y]);
                x += dr;
                y += dc;
            }
            if (x >= 0 && x < m && y >= 0 && y < n && board[x][y] === 'x') {
                for (const [px, py] of path) {
                    if (!visited.has(`${px},${py}`)) {
                        visited.add(`${px},${py}`);
                        queue.push([px, py]);
                        count++;
                    }
                }
            }
        }
    }

    return count;
}