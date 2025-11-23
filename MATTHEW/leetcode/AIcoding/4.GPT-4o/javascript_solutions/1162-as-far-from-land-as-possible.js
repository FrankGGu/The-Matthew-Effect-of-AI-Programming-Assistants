var maxDistance = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const queue = [];
    let distance = -1;

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) {
                queue.push([r, c]);
            }
        }
    }

    while (queue.length) {
        distance++;
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [r, c] = queue.shift();
            for (const [dr, dc] of [[1, 0], [-1, 0], [0, 1], [0, -1]]) {
                const nr = r + dr, nc = c + dc;
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] === 0) {
                    grid[nr][nc] = 1;
                    queue.push([nr, nc]);
                }
            }
        }
    }

    return distance === 0 ? -1 : distance;
};