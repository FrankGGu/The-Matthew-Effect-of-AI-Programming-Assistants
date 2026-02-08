var minPushBox = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let box, target, player;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'B') box = [i, j];
            else if (grid[i][j] === 'T') target = [i, j];
            else if (grid[i][j] === 'S') player = [i, j];
        }
    }

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const visited = new Set();
    const queue = [[...box, ...player, 0]];
    visited.add(`${box[0]},${box[1]},${player[0]},${player[1]}`);

    while (queue.length > 0) {
        const [bx, by, px, py, moves] = queue.shift();

        if (bx === target[0] && by === target[1]) {
            return moves;
        }

        for (const [dx, dy] of dirs) {
            const nx = px + dx;
            const ny = py + dy;

            if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] === '#') {
                continue;
            }

            if (nx === bx && ny === by) {
                const nbx = bx + dx;
                const nby = by + dy;

                if (nbx < 0 || nbx >= m || nby < 0 || nby >= n || grid[nbx][nby] === '#') {
                    continue;
                }

                const key = `${nbx},${nby},${nx},${ny}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nbx, nby, nx, ny, moves + 1]);
                }
            } else {
                const key = `${bx},${by},${nx},${ny}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.unshift([bx, by, nx, ny, moves]);
                }
            }
        }
    }

    return -1;
};