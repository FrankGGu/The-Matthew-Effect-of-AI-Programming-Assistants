var minFlips = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const totalOnes = m * n / 2;
    const target = (1 << totalOnes) - 1;

    const start = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n / 2; j++) {
            if (grid[i][j] !== grid[i][n - 1 - j]) {
                if (grid[i][j] === 1) {
                    return -1;
                }
            }
        }
    }

    let initialState = 0;
    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n / 2; j++) {
            if (grid[i][j] === 1) {
                initialState |= (1 << count);
            }
            count++;
        }
    }

    const queue = [[initialState, 0]];
    const visited = new Set();
    visited.add(initialState);

    while (queue.length > 0) {
        const [currState, flips] = queue.shift();

        if (currState === target) {
            return flips;
        }

        for (let i = 0; i < totalOnes; i++) {
            const nextState = currState ^ (1 << i);
            if (!visited.has(nextState)) {
                visited.add(nextState);
                queue.push([nextState, flips + 1]);
            }
        }
    }

    return -1;
};