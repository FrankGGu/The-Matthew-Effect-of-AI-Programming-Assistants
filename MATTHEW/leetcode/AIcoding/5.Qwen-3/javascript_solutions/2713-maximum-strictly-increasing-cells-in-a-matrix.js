function maxIncreasingCells(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    const map = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (!map.has(matrix[i][j])) {
                map.set(matrix[i][j], []);
            }
            map.get(matrix[i][j]).push([i, j]);
        }
    }

    const sortedValues = [...map.keys()].sort((a, b) => a - b);

    for (const val of sortedValues) {
        const cells = map.get(val);
        for (const [i, j] of cells) {
            let max = 0;
            if (i > 0) max = Math.max(max, dp[i - 1][j]);
            if (i < m - 1) max = Math.max(max, dp[i + 1][j]);
            if (j > 0) max = Math.max(max, dp[i][j - 1]);
            if (j < n - 1) max = Math.max(max, dp[i][j + 1]);
            dp[i][j] = max + 1;
        }
    }

    let result = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            result = Math.max(result, dp[i][j]);
        }
    }

    return result;
}