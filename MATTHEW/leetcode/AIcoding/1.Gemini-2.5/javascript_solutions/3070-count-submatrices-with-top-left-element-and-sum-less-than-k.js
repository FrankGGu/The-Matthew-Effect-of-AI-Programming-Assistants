var countSubmatrices = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    let count = 0;

    const ps = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            let currentSum = grid[r][c];

            if (r > 0) {
                currentSum += ps[r - 1][c];
            }

            if (c > 0) {
                currentSum += ps[r][c - 1];
            }

            if (r > 0 && c > 0) {
                currentSum -= ps[r - 1][c - 1];
            }

            ps[r][c] = currentSum;

            if (ps[r][c] < k) {
                count++;
            }
        }
    }

    return count;
};