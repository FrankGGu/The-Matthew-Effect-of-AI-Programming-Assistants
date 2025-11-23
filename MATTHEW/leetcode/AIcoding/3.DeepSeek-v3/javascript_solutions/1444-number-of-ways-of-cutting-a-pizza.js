var ways = function(pizza, k) {
    const MOD = 1e9 + 7;
    const rows = pizza.length;
    const cols = pizza[0].length;

    const prefixSum = Array.from({ length: rows + 1 }, () => Array(cols + 1).fill(0));
    for (let i = rows - 1; i >= 0; i--) {
        for (let j = cols - 1; j >= 0; j--) {
            prefixSum[i][j] = (pizza[i].charAt(j) === 'A' ? 1 : 0) + 
                              prefixSum[i + 1][j] + 
                              prefixSum[i][j + 1] - 
                              prefixSum[i + 1][j + 1];
        }
    }

    const dp = Array.from({ length: k }, () => Array(rows).fill().map(() => Array(cols).fill(0)));

    for (let i = rows - 1; i >= 0; i--) {
        for (let j = cols - 1; j >= 0; j--) {
            dp[0][i][j] = prefixSum[i][j] > 0 ? 1 : 0;
        }
    }

    for (let cut = 1; cut < k; cut++) {
        for (let i = rows - 1; i >= 0; i--) {
            for (let j = cols - 1; j >= 0; j--) {
                let total = 0;
                for (let x = i + 1; x < rows; x++) {
                    if (prefixSum[i][j] - prefixSum[x][j] > 0) {
                        total = (total + dp[cut - 1][x][j]) % MOD;
                    }
                }
                for (let y = j + 1; y < cols; y++) {
                    if (prefixSum[i][j] - prefixSum[i][y] > 0) {
                        total = (total + dp[cut - 1][i][y]) % MOD;
                    }
                }
                dp[cut][i][j] = total;
            }
        }
    }

    return dp[k - 1][0][0];
};