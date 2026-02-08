function maxPaths(board) {
    const MOD = 10 ** 9 + 7;
    const m = board.length;
    const n = board[0].length;

    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    const count = Array.from({ length: m }, () => Array(n).fill(0));

    dp[m - 1][n - 1] = parseInt(board[m - 1][n - 1]) || 0;
    count[m - 1][n - 1] = 1;

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (i === m - 1 && j === n - 1) continue;

            let maxVal = -Infinity;
            let total = 0;

            if (i + 1 < m) {
                const val = dp[i + 1][j];
                if (val > maxVal) {
                    maxVal = val;
                    total = count[i + 1][j];
                } else if (val === maxVal) {
                    total += count[i + 1][j];
                }
            }

            if (j + 1 < n) {
                const val = dp[i][j + 1];
                if (val > maxVal) {
                    maxVal = val;
                    total = count[i][j + 1];
                } else if (val === maxVal) {
                    total += count[i][j + 1];
                }
            }

            if (i + 1 < m && j + 1 < n) {
                const val = dp[i + 1][j + 1];
                if (val > maxVal) {
                    maxVal = val;
                    total = count[i + 1][j + 1];
                } else if (val === maxVal) {
                    total += count[i + 1][j + 1];
                }
            }

            if (maxVal !== -Infinity) {
                dp[i][j] = maxVal + (parseInt(board[i][j]) || 0);
                count[i][j] = total % MOD;
            }
        }
    }

    return [dp[0][0], count[0][0]];
}