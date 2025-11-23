var maxIncreasingCells = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const positions = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const val = mat[i][j];
            if (!positions.has(val)) {
                positions.set(val, []);
            }
            positions.get(val).push([i, j]);
        }
    }

    const sortedValues = Array.from(positions.keys()).sort((a, b) => a - b);
    const rowMax = new Array(m).fill(0);
    const colMax = new Array(n).fill(0);
    const dp = Array.from({ length: m }, () => new Array(n).fill(0));

    for (const val of sortedValues) {
        const cells = positions.get(val);
        const updates = [];

        for (const [i, j] of cells) {
            dp[i][j] = Math.max(rowMax[i], colMax[j]) + 1;
            updates.push([i, j, dp[i][j]]);
        }

        for (const [i, j, curr] of updates) {
            rowMax[i] = Math.max(rowMax[i], curr);
            colMax[j] = Math.max(colMax[j], curr);
        }
    }

    return Math.max(...rowMax, ...colMax);
};