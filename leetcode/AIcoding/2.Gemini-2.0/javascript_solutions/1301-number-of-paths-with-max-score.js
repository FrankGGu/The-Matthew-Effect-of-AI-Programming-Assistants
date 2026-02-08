var pathsWithMaxScore = function(board) {
    const n = board.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(0));
    const ways = Array(n).fill(null).map(() => Array(n).fill(0));
    ways[n - 1][n - 1] = 1;

    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (board[i][j] === 'X') {
                continue;
            }

            if (i === n - 1 && j === n - 1) {
                dp[i][j] = 0;
                ways[i][j] = 1;
                continue;
            }

            let val = (board[i][j] === 'S' ? 0 : parseInt(board[i][j]));
            let maxScore = -Infinity;
            let totalWays = 0;
            const mod = 10**9 + 7;

            if (i + 1 < n && ways[i + 1][j] > 0) {
                if (dp[i + 1][j] + val > maxScore) {
                    maxScore = dp[i + 1][j] + val;
                    totalWays = ways[i + 1][j];
                } else if (dp[i + 1][j] + val === maxScore) {
                    totalWays = (totalWays + ways[i + 1][j]) % mod;
                }
            }

            if (j + 1 < n && ways[i][j + 1] > 0) {
                if (dp[i][j + 1] + val > maxScore) {
                    maxScore = dp[i][j + 1] + val;
                    totalWays = ways[i][j + 1];
                } else if (dp[i][j + 1] + val === maxScore) {
                    totalWays = (totalWays + ways[i][j + 1]) % mod;
                }
            }

            if (i + 1 < n && j + 1 < n && ways[i + 1][j + 1] > 0) {
                if (dp[i + 1][j + 1] + val > maxScore) {
                    maxScore = dp[i + 1][j + 1] + val;
                    totalWays = ways[i + 1][j + 1];
                } else if (dp[i + 1][j + 1] + val === maxScore) {
                    totalWays = (totalWays + ways[i + 1][j + 1]) % mod;
                }
            }

            if (maxScore !== -Infinity) {
                dp[i][j] = maxScore;
                ways[i][j] = totalWays;
            }
        }
    }

    if (ways[0][0] === 0) {
        return [0, 0];
    }

    return [dp[0][0], ways[0][0]];
};