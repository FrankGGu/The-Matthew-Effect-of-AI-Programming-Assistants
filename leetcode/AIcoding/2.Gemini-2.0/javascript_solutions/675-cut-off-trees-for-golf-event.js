var cutOffTree = function(forest) {
    const m = forest.length;
    const n = forest[0].length;
    const trees = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (forest[i][j] > 1) {
                trees.push([forest[i][j], i, j]);
            }
        }
    }

    trees.sort((a, b) => a[0] - b[0]);

    let sr = 0;
    let sc = 0;
    let totalSteps = 0;

    for (const [_, tr, tc] of trees) {
        const steps = bfs(forest, sr, sc, tr, tc);
        if (steps === -1) {
            return -1;
        }
        totalSteps += steps;
        sr = tr;
        sc = tc;
    }

    return totalSteps;

    function bfs(forest, startRow, startCol, targetRow, targetCol) {
        const m = forest.length;
        const n = forest[0].length;
        const visited = Array(m).fill(null).map(() => Array(n).fill(false));
        const queue = [[startRow, startCol, 0]];
        visited[startRow][startCol] = true;
        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        while (queue.length > 0) {
            const [row, col, steps] = queue.shift();

            if (row === targetRow && col === targetCol) {
                return steps;
            }

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && forest[newRow][newCol] !== 0 && !visited[newRow][newCol]) {
                    queue.push([newRow, newCol, steps + 1]);
                    visited[newRow][newCol] = true;
                }
            }
        }

        return -1;
    }
};