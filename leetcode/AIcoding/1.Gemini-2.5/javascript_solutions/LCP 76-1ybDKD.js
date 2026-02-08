var minFlips = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    const matrixToInt = (matrix) => {
        let val = 0;
        for (let r = 0; r < m; r++) {
            for (let c = 0; c < n; c++) {
                if (matrix[r][c] === 1) {
                    val |= (1 << (r * n + c));
                }
            }
        }
        return val;
    };

    const flipState = (state, r, c) => {
        let newState = state;
        const dirs = [[0, 0], [0, 1], [0, -1], [1, 0], [-1, 0]];
        for (const [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const bitPos = nr * n + nc;
                newState ^= (1 << bitPos);
            }
        }
        return newState;
    };

    const initialState = matrixToInt(mat);
    if (initialState === 0) {
        return 0;
    }

    const queue = [[initialState, 0]];
    const visited = new Set();
    visited.add(initialState);

    let head = 0;
    while (head < queue.length) {
        const [currentState, flips] = queue[head++];

        for (let r = 0; r < m; r++) {
            for (let c = 0; c < n; c++) {
                const nextState = flipState(currentState, r, c);
                if (nextState === 0) {
                    return flips + 1;
                }
                if (!visited.has(nextState)) {
                    visited.add(nextState);
                    queue.push([nextState, flips + 1]);
                }
            }
        }
    }

    return -1;
};