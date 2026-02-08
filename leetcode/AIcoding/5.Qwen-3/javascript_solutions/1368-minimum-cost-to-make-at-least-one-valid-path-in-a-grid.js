function minCost(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const cost = Array.from({ length: m }, () => Array(n).fill(Infinity));
    const pq = [];

    cost[0][0] = 0;
    pq.push([0, 0, 0]);

    while (pq.length > 0) {
        const [c, x, y] = pq.shift();

        if (x === m - 1 && y === n - 1) break;

        if (c > cost[x][y]) continue;

        for (let d = 0; d < 4; d++) {
            const nx = x + dirs[d][0];
            const ny = y + dirs[d][1];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                const newCost = c + (d === grid[x][y] - 1 ? 0 : 1);
                if (newCost < cost[nx][ny]) {
                    cost[nx][ny] = newCost;
                    pq.push([newCost, nx, ny]);
                }
            }
        }
    }

    return cost[m - 1][n - 1];
}