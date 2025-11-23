var minCost = function(grid) {
    const m = grid.length, n = grid[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const costs = Array.from({ length: m }, () => Array(n).fill(Infinity));
    const queue = [[0, 0, 0]];
    costs[0][0] = 0;

    while (queue.length) {
        const [x, y, cost] = queue.shift();

        for (let i = 0; i < 4; i++) {
            const nx = x + directions[i][0];
            const ny = y + directions[i][1];
            const newCost = cost + (grid[x][y] - 1 !== i ? 1 : 0);
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && newCost < costs[nx][ny]) {
                costs[nx][ny] = newCost;
                queue.push([nx, ny, newCost]);
            }
        }
    }
    return costs[m - 1][n - 1];
};