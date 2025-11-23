var largest1BorderedSquare = function(grid) {
    const M = grid.length;
    if (M === 0) {
        return 0;
    }
    const N = grid[0].length;
    if (N === 0) {
        return 0;
    }

    const horz = Array(M).fill(0).map(() => Array(N).fill(0));
    const vert = Array(M).fill(0).map(() => Array(N).fill(0));

    for (let r = 0; r < M; r++) {
        for (let c = 0; c < N; c++) {
            if (grid[r][c] === 1) {
                horz[r][c] = (c > 0 ? horz[r][c - 1] : 0) + 1;
                vert[r][c] = (r > 0 ? vert[r - 1][c] : 0) + 1;
            }
        }
    }

    let maxArea = 0;

    for (let r = 0; r < M; r++) {
        for (let c = 0; c < N; c++) {
            const max_k = Math.min(horz[r][c], vert[r][c]);

            for (let k = max_k; k >= 1; k--) {
                if (horz[r - k + 1][c] >= k && vert[r][c - k + 1] >= k) {
                    maxArea = Math.max(maxArea, k * k);
                    break;
                }
            }
        }
    }

    return maxArea;
};