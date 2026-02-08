var fillTheGrid = function(n, m, queries) {
    const grid = Array(n).fill(null).map(() => Array(m).fill(0));

    for (const query of queries) {
        const type = query[0];
        const index = query[1];
        const color = query[2];

        if (type === 0) {
            for (let j = 0; j < m; j++) {
                grid[index][j] = color;
            }
        } else {
            for (let i = 0; i < n; i++) {
                grid[i][index] = color;
            }
        }
    }

    return grid;
};