var minimumMoves = function(grid) {
    const sources = [];
    const targets = [];

    for (let r = 0; r < 3; r++) {
        for (let c = 0; c < 3; c++) {
            if (grid[r][c] > 1) {
                for (let i = 0; i < grid[r][c] - 1; i++) {
                    sources.push([r, c]);
                }
            } else if (grid[r][c] === 0) {
                targets.push([r, c]);
            }
        }
    }

    const N = sources.length;
    if (N === 0) {
        return 0;
    }

    const memo = new Map();

    function calculateMinCost(sourceIdx, targetMask) {
        if (sourceIdx === N) {
            return 0;
        }

        const stateKey = `${sourceIdx},${targetMask}`;
        if (memo.has(stateKey)) {
            return memo.get(stateKey);
        }

        let minTotalCost = Infinity;
        const [sr, sc] = sources[sourceIdx];

        for (let j = 0; j < N; j++) {
            if (!((targetMask >> j) & 1)) {
                const [tr, tc] = targets[j];
                const currentMoveCost = Math.abs(sr - tr) + Math.abs(sc - tc);

                const remainingCost = calculateMinCost(sourceIdx + 1, targetMask | (1 << j));

                minTotalCost = Math.min(minTotalCost, currentMoveCost + remainingCost);
            }
        }

        memo.set(stateKey, minTotalCost);
        return minTotalCost;
    }

    return calculateMinCost(0, 0);
};