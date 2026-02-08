var minFlips = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    let initialState = 0;
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (mat[r][c] === 1) {
                initialState |= (1 << (r * n + c));
            }
        }
    }

    const queue = [[initialState, 0]];
    const visited = new Set();
    visited.add(initialState);

    const dr = [0, 0, 0, 1, -1];
    const dc = [0, 1, -1, 0, 0];

    const applyFlip = (currentState, r, c) => {
        let mask = 0;
        for (let k = 0; k < 5; k++) {
            const nr = r + dr[k];
            const nc = c + dc[k];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const pos = nr * n + nc;
                mask |= (1 << pos);
            }
        }
        return currentState ^ mask;
    };

    while (queue.length > 0) {
        const [currentState, steps] = queue.shift();

        if (currentState === 0) {
            return steps;
        }

        for (let r = 0; r < m; r++) {
            for (let c = 0; c < n; c++) {
                const nextState = applyFlip(currentState, r, c);

                if (!visited.has(nextState)) {
                    visited.add(nextState);
                    queue.push([nextState, steps + 1]);
                }
            }
        }
    }

    return -1;
};