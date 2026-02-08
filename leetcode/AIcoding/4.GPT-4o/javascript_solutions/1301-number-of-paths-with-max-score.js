var pathsWithMaxScore = function(board) {
    const n = board.length;
    const m = board[0].length;
    const dp = Array.from({ length: n }, () => Array(m).fill(0));
    const count = Array.from({ length: n }, () => Array(m).fill(0));

    dp[n - 1][m - 1] = board[n - 1][m - 1] === 'E' ? 0 : Number(board[n - 1][m - 1]);
    count[n - 1][m - 1] = 1;

    for (let i = n - 1; i >= 0; i--) {
        for (let j = m - 1; j >= 0; j--) {
            if (board[i][j] === 'X') continue;
            const score = board[i][j] === 'E' ? 0 : Number(board[i][j]);
            if (i + 1 < n) {
                if (dp[i + 1][j] > dp[i][j] || (dp[i + 1][j] === dp[i][j] && count[i + 1][j] > 0)) {
                    dp[i][j] = dp[i + 1][j] + score;
                    count[i][j] = count[i + 1][j];
                } else if (dp[i + 1][j] === dp[i][j]) {
                    count[i][j] += count[i + 1][j];
                }
            }
            if (j + 1 < m) {
                if (dp[i][j + 1] > dp[i][j] || (dp[i][j + 1] === dp[i][j] && count[i][j + 1] > 0)) {
                    dp[i][j] = dp[i][j + 1] + score;
                    count[i][j] = count[i][j + 1];
                } else if (dp[i][j + 1] === dp[i][j]) {
                    count[i][j] += count[i][j + 1];
                }
            }
        }
    }

    return dp[0][0] === 0 ? [0, 0] : [dp[0][0], count[0][0]];
};