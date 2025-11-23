var kthNearestObstacle = function(m, n, obstacles, queries) {
    const grid = Array(m).fill(null).map(() => Array(n).fill(0));
    for (const [row, col] of obstacles) {
        grid[row][col] = 1;
    }

    const results = [];
    for (const [row, col, k] of queries) {
        const distances = [];
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1) {
                    distances.push([Math.abs(row - i) + Math.abs(col - j), i, j]);
                }
            }
        }

        distances.sort((a, b) => a[0] - b[0]);

        if (distances.length < k) {
            results.push(-1);
        } else {
            results.push((distances[k - 1][1] * n) + distances[k - 1][2]);
        }
    }

    return results;
};