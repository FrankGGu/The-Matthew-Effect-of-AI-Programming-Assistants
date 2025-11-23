function minimumMoves(grid, start, target) {
    const n = grid.length;
    const m = grid[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]; // right, down, left, up
    const queue = [[start[0], start[1], 0, 0]]; // x, y, direction, moves
    const visited = new Set();
    visited.add(start[0] + ',' + start[1] + ',0');

    while (queue.length) {
        const [x, y, dir, moves] = queue.shift();

        if (x === target[0] && y === target[1]) return moves;

        const nextMoves = [
            [x + directions[dir][0], y + directions[dir][1], dir], // move forward
            [x, y, (dir + 1) % 4], // rotate right
            [x, y, (dir + 3) % 4]  // rotate left
        ];

        for (const [nx, ny, ndir] of nextMoves) {
            if (nx >= 0 && ny >= 0 && nx < n && ny < m && grid[nx][ny] === 0) {
                const key = nx + ',' + ny + ',' + ndir;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny, ndir, moves + 1]);
                }
            }
        }
    }
    return -1;
}