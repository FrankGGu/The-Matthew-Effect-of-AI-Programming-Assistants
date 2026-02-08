var waysToCutPizza = function(pizza, k) {
    const m = pizza.length, n = pizza[0].length;
    const dp = Array.from({ length: k }, () => Array(m).fill().map(() => Array(n).fill(0)));
    const prefix = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            prefix[i][j] = (pizza[i][j] === 'A' ? 1 : 0) + prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1];
        }
    }

    const hasApple = (x1, y1, x2, y2) => prefix[x1][y1] - prefix[x2][y1] - prefix[x1][y2] + prefix[x2][y2] > 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            dp[0][i][j] = 1;
        }
    }

    for (let cuts = 1; cuts < k; cuts++) {
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                for (let x = i + 1; x < m; x++) {
                    if (hasApple(i, j, x, n)) {
                        dp[cuts][i][j] = (dp[cuts][i][j] + dp[cuts - 1][x][j]) % 1000000007;
                    }
                }
                for (let y = j + 1; y < n; y++) {
                    if (hasApple(i, j, m, y)) {
                        dp[cuts][i][j] = (dp[cuts][i][j] + dp[cuts - 1][i][y]) % 1000000007;
                    }
                }
            }
        }
    }

    return dp[k - 1][0][0];
};