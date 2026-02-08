var maxIncreasingCells = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    const rows = Array(m).fill(0);
    const cols = Array(n).fill(0);

    const cells = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            cells.push([mat[i][j], i, j]);
        }
    }

    cells.sort((a, b) => a[0] - b[0]);

    const dp = Array(m).fill(null).map(() => Array(n).fill(0));
    let ans = 0;

    for (let i = 0; i < cells.length; i++) {
        const [val, row, col] = cells[i];

        let maxVal = 0;
        for (let j = 0; j < n; j++) {
            if (j !== col && mat[row][j] < val) {
                maxVal = Math.max(maxVal, dp[row][j]);
            }
        }

        for (let j = 0; j < m; j++) {
            if (j !== row && mat[j][col] < val) {
                maxVal = Math.max(maxVal, dp[j][col]);
            }
        }

        dp[row][col] = maxVal + 1;
        ans = Math.max(ans, dp[row][col]);
    }

    return ans;
};