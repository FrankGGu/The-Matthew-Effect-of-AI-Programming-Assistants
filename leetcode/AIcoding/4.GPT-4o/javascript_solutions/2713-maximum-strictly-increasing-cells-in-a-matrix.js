function maxIncreasingCells(mat) {
    const m = mat.length, n = mat[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(1));
    const cells = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            cells.push([mat[i][j], i, j]);
        }
    }

    cells.sort((a, b) => a[0] - b[0]);

    const rowMax = Array(m).fill(0);
    const colMax = Array(n).fill(0);

    for (const [value, i, j] of cells) {
        dp[i][j] = Math.max(dp[i][j], rowMax[i] + 1, colMax[j] + 1);
        rowMax[i] = Math.max(rowMax[i], dp[i][j]);
        colMax[j] = Math.max(colMax[j], dp[i][j]);
    }

    return Math.max(...dp.flat());
}