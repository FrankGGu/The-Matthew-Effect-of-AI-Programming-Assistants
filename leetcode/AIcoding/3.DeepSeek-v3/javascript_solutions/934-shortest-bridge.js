var shortestBridge = function(grid) {
    const n = grid.length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let queue = [];

    const dfs = (i, j) => {
        if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] !== 1) {
            return;
        }
        grid[i][j] = 2;
        queue.push([i, j]);
        for (const [dx, dy] of dirs) {
            dfs(i + dx, j + dy);
        }
    };

    outer: for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                break outer;
            }
        }
    }

    let steps = 0;
    while (queue.length > 0) {
        const newQueue = [];
        for (const [i, j] of queue) {
            for (const [dx, dy] of dirs) {
                const x = i + dx;
                const y = j + dy;
                if (x >= 0 && x < n && y >= 0 && y < n) {
                    if (grid[x][y] === 1) {
                        return steps;
                    }
                    if (grid[x][y] === 0) {
                        grid[x][y] = 2;
                        newQueue.push([x, y]);
                    }
                }
            }
        }
        queue = newQueue;
        steps++;
    }
    return -1;
};