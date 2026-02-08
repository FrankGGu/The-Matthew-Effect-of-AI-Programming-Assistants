var orangesRotting = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const queue = [];
    let freshOranges = 0;
    let maxTime = 0;

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 2) {
                queue.push([r, c, 0]);
            } else if (grid[r][c] === 1) {
                freshOranges++;
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    let head = 0;
    while (head < queue.length) {
        const [r, c, time] = queue[head++];
        maxTime = Math.max(maxTime, time);

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] === 1) {
                grid[nr][nc] = 2; // Mark as rotted
                freshOranges--;
                queue.push([nr, nc, time + 1]);
            }
        }
    }

    return freshOranges === 0 ? maxTime : -1;
};