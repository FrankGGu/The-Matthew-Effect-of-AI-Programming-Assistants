var pathsWithMaxScore = function(board) {
    const R = board.length;
    const C = board[0].length;
    const MOD = 1_000_000_007;

    const dp = Array(R).fill(0).map(() => Array(C).fill(0).map(() => [Number.MIN_SAFE_INTEGER, 0]));

    dp[R - 1][C - 1] = [0, 1];

    for (let r = R - 1; r >= 0; r--) {
        for (let c = C - 1; c >= 0; c--) {
            if (board[r][c] === 'X' || (r === R - 1 && c === C - 1)) {
                continue;
            }

            const currentCellValue = board[r][c] === 'S' ? 0 : parseInt(board[r][c]);

            let maxPrevScore = Number.MIN_SAFE_INTEGER;
            let numPrevPaths = 0;

            if (r + 1 < R && dp[r + 1][c][0] !== Number.MIN_SAFE_INTEGER) {
                const [score, paths] = dp[r + 1][c];
                if (score > maxPrevScore) {
                    maxPrevScore = score;
                    numPrevPaths = paths;
                } else if (score === maxPrevScore) {
                    numPrevPaths = (numPrevPaths + paths) % MOD;
                }
            }

            if (c + 1 < C && dp[r][c + 1][0] !== Number.MIN_SAFE_INTEGER) {
                const [score, paths] = dp[r][c + 1];
                if (score > maxPrevScore) {
                    maxPrevScore = score;
                    numPrevPaths = paths;
                } else if (score === maxPrevScore) {
                    numPrevPaths = (numPrevPaths + paths) % MOD;
                }
            }

            if (r + 1 < R && c + 1 < C && dp[r + 1][c + 1][0] !== Number.MIN_SAFE_INTEGER) {
                const [score, paths] = dp[r + 1][c + 1];
                if (score > maxPrevScore) {
                    maxPrevScore = score;
                    numPrevPaths = paths;
                } else if (score === maxPrevScore) {
                    numPrevPaths = (numPrevPaths + paths) % MOD;
                }
            }

            if (maxPrevScore !== Number.MIN_SAFE_INTEGER) {
                dp[r][c][0] = currentCellValue + maxPrevScore;
                dp[r][c][1] = numPrevPaths;
            }
        }
    }

    const finalScore = dp[0][0][0];
    const finalPaths = dp[0][0][1];

    if (finalScore === Number.MIN_SAFE_INTEGER) {
        return [0, 0];
    } else {
        return [finalScore, finalPaths];
    }
};