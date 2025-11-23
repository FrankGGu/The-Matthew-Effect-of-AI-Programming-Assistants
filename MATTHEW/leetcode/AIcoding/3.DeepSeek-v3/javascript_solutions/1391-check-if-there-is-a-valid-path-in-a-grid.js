var hasValidPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = {
        1: [[0, -1], [0, 1]],
        2: [[-1, 0], [1, 0]],
        3: [[0, -1], [1, 0]],
        4: [[0, 1], [1, 0]],
        5: [[0, -1], [-1, 0]],
        6: [[-1, 0], [0, 1]]
    };
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    const queue = [[0, 0]];
    visited[0][0] = true;

    while (queue.length > 0) {
        const [i, j] = queue.shift();
        if (i === m - 1 && j === n - 1) return true;

        for (const [di, dj] of directions[grid[i][j]]) {
            const ni = i + di;
            const nj = j + dj;
            if (ni < 0 || ni >= m || nj < 0 || nj >= n || visited[ni][nj]) continue;

            for (const [ndi, ndj] of directions[grid[ni][nj]]) {
                if (ni + ndi === i && nj + ndj === j) {
                    visited[ni][nj] = true;
                    queue.push([ni, nj]);
                    break;
                }
            }
        }
    }

    return false;
};