var orderOfLargestPlusSign = function(N, mines) {
    const grid = new Array(N).fill(0).map(() => new Array(N).fill(1));
    for (const [x, y] of mines) {
        grid[x][y] = 0;
    }

    const left = new Array(N).fill(0).map(() => new Array(N).fill(0));
    const right = new Array(N).fill(0).map(() => new Array(N).fill(0));
    const up = new Array(N).fill(0).map(() => new Array(N).fill(0));
    const down = new Array(N).fill(0).map(() => new Array(N).fill(0));

    for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
            if (grid[i][j] === 1) {
                left[i][j] = (j === 0) ? 1 : left[i][j - 1] + 1;
                up[i][j] = (i === 0) ? 1 : up[i - 1][j] + 1;
            }
        }
    }

    for (let i = N - 1; i >= 0; i--) {
        for (let j = N - 1; j >= 0; j--) {
            if (grid[i][j] === 1) {
                right[i][j] = (j === N - 1) ? 1 : right[i][j + 1] + 1;
                down[i][j] = (i === N - 1) ? 1 : down[i + 1][j] + 1;
            }
        }
    }

    let maxOrder = 0;
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < N; j++) {
            const order = Math.min(left[i][j], right[i][j], up[i][j], down[i][j]);
            maxOrder = Math.max(maxOrder, order);
        }
    }

    return maxOrder;
};