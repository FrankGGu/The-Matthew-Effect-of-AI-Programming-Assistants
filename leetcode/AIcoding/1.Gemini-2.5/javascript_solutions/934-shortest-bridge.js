var shortestBridge = function(grid) {
    const n = grid.length;
    const q = [];
    let foundFirstIsland = false;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    function dfs(r, c) {
        if (r < 0 || r >= n || c < 0 || c >= n || grid[r][c] !== 1) {
            return;
        }
        grid[r][c] = 2;
        q.push([r, c]);
        for (const [dr, dc] of directions) {
            dfs(r + dr, c + dc);
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                foundFirstIsland = true;
                break;
            }
        }
        if (foundFirstIsland) {
            break;
        }
    }

    let distance = 0;
    let head = 0;

    while (head < q.length) {
        let levelSize = q.length - head;

        for (let i = 0; i < levelSize; i++) {
            const [r, c] = q[head++];

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    if (grid[nr][nc] === 1) {
                        return distance;
                    }
                    if (grid[nr][nc] === 0) {
                        grid[nr][nc] = 2;
                        q.push([nr, nc]);
                    }
                }
            }
        }
        distance++;
    }

    return -1;
};