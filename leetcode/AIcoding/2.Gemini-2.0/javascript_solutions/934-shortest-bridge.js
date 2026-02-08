var shortestBridge = function(grid) {
    const n = grid.length;
    let island1 = [];
    let found = false;

    function dfs(i, j) {
        if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] !== 1) {
            return;
        }
        grid[i][j] = 2;
        island1.push([i, j]);
        dfs(i + 1, j);
        dfs(i - 1, j);
        dfs(i, j + 1);
        dfs(i, j - 1);
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                found = true;
                break;
            }
        }
        if (found) break;
    }

    let queue = island1;
    let steps = 0;

    while (queue.length > 0) {
        let nextQueue = [];
        for (let [i, j] of queue) {
            let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
            for (let [di, dj] of directions) {
                let ni = i + di;
                let nj = j + dj;

                if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                    if (grid[ni][nj] === 1) {
                        return steps;
                    } else if (grid[ni][nj] === 0) {
                        grid[ni][nj] = 2;
                        nextQueue.push([ni, nj]);
                    }
                }
            }
        }
        queue = nextQueue;
        steps++;
    }

    return -1;
};