const countArrays = function(n, m, k) {
    const MOD = 1e9 + 7;
    let dp = Array.from({ length: n + 1 }, () => Array.from({ length: k + 1 }, () => Array(m + 1).fill(0)));

    for (let num = 1; num <= m; num++) {
        dp[1][0][num] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            for (let num = 1; num <= m; num++) {
                let sum = 0;
                for (let prevNum = 1; prevNum <= m; prevNum++) {
                    if (prevNum === num) {
                        if (j > 0) {
                            sum = (sum + dp[i - 1][j - 1][prevNum]) % MOD;
                        }
                    } else {
                        sum = (sum + dp[i - 1][j][prevNum]) % MOD;
                    }
                }
                dp[i][j][num] = sum;
            }
        }
    }

    let result = 0;
    for (let num = 1; num <= m; num++) {
        result = (result + dp[n][k][num]) % MOD;
    }

    return result;
};