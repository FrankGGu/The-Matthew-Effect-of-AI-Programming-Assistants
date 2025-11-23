var onesMinusZeros = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const rowOnes = new Array(m).fill(0);
    const colOnes = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                rowOnes[i]++;
                colOnes[j]++;
            }
        }
    }

    const diff = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            diff[i][j] = rowOnes[i] + colOnes[j] - (n - rowOnes[i]) - (m - colOnes[j]);
        }
    }

    return diff;
};