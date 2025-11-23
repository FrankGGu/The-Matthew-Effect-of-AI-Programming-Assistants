var minMoves = function(grid, k) {
    const R = grid.length;
    const C = grid[0].length;

    let startR, startC, endR, endC;
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (grid[r][c] === '2') {
                startR = r;
                startC = c;
            } else if (grid[r][c] === '3') {
                endR = r;
                endC = c;
            }
        }
    }

    const queue = [[startR, startC, k, 0]];
    const visited = new Set();
    visited.add(`${startR},${startC},${k}`);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [r, c, battery, moves] = queue.shift();

        if (r === endR && c === endC) {
            return moves;
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr < 0 || nr >= R || nc < 0 || nc >= C) {
                continue;
            }

            let nextBattery;
            if (grid[nr][nc] === '1') {
                nextBattery = k;
            } else {
                nextBattery = battery - 1;
            }

            if (nextBattery < 0) {
                continue;
            }

            const stateKey = `${nr},${nc},${nextBattery}`;
            if (!visited.has(stateKey)) {
                visited.add(stateKey);
                queue.push([nr, nc, nextBattery, moves + 1]);
            }
        }
    }

    return -1;
};