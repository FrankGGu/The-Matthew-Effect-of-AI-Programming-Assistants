var maxPoints = function(grid, queries) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));
    const points = [];
    const pq = [[grid[0][0], 0, 0]];
    visited[0][0] = true;

    queries = queries.map((val, index) => [val, index]).sort((a, b) => a[0] - b[0]);
    const ans = Array(queries.length);
    let count = 0;

    for (const [query, index] of queries) {
        while (pq.length > 0 && pq[0][0] < query) {
            const [val, row, col] = pq.shift();
            count++;

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                    pq.push([grid[newRow][newCol], newRow, newCol]);
                    visited[newRow][newCol] = true;
                }
            }
            pq.sort((a, b) => a[0] - b[0]);
        }
        ans[index] = count;
    }

    return ans;
};