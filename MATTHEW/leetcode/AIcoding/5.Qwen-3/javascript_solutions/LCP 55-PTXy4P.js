function minTimeToCollectFruits(grid, workers) {
    const rows = grid.length;
    const cols = grid[0].length;
    const n = workers.length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function bfs(startRow, startCol) {
        const visited = Array.from({ length: rows }, () => Array(cols).fill(-1));
        const queue = [[startRow, startCol]];
        visited[startRow][startCol] = 0;

        while (queue.length > 0) {
            const [r, c] = queue.shift();
            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && visited[nr][nc] === -1) {
                    visited[nr][nc] = visited[r][c] + 1;
                    queue.push([nr, nc]);
                }
            }
        }
        return visited;
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const [r, c] = workers[i];
        const dist = bfs(r, c);
        let minTime = Infinity;
        for (let x = 0; x < rows; x++) {
            for (let y = 0; y < cols; y++) {
                if (grid[x][y] > 0 && dist[x][y] !== -1) {
                    minTime = Math.min(minTime, dist[x][y] * grid[x][y]);
                }
            }
        }
        result.push(minTime);
    }
    return result;
}