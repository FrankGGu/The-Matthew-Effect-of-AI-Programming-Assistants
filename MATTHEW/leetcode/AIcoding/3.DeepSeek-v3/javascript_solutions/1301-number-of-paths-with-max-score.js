var pathsWithMaxScore = function(board) {
    const n = board.length;
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: n }, () => Array(n).fill([0, 0]));

    dp[n - 1][n - 1] = [0, 1];

    for (let i = n - 1; i >= 0; --i) {
        for (let j = n - 1; j >= 0; --j) {
            if (board[i][j] === 'X' || (i === n - 1 && j === n - 1)) continue;

            let maxScore = 0;
            let count = 0;

            const directions = [[i + 1, j], [i, j + 1], [i + 1, j + 1]];

            for (const [x, y] of directions) {
                if (x < n && y < n) {
                    const [score, cnt] = dp[x][y];
                    if (cnt > 0) {
                        if (score > maxScore) {
                            maxScore = score;
                            count = cnt;
                        } else if (score === maxScore) {
                            count += cnt;
                        }
                    }
                }
            }

            if (count > 0) {
                const currentVal = board[i][j] === 'E' ? 0 : parseInt(board[i][j]);
                dp[i][j] = [maxScore + currentVal, count % MOD];
            } else {
                dp[i][j] = [0, 0];
            }
        }
    }

    return dp[0][0][1] === 0 ? [0, 0] : [dp[0][0][0], dp[0][0][1] % MOD];
};