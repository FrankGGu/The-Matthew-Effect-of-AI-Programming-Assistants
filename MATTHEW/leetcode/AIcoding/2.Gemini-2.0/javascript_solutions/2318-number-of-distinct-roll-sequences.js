var distinctSequences = function(n) {
    const MOD = 10**9 + 7;
    let dp = Array(n + 1).fill(null).map(() => Array(7).fill(null).map(() => Array(7).fill(0)));

    for (let i = 1; i <= 6; i++) {
        dp[1][0][i] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= 6; j++) {
            for (let k = 1; k <= 6; k++) {
                if (k != j) {
                    for (let l = 1; l <= 6; l++) {
                        if (l != j && l != k && gcd(j, l) == 1) {
                            dp[i][j][l] = (dp[i][j][l] + dp[i - 1][k][j]) % MOD;
                        }
                    }
                }
            }
        }
    }

    let ans = 0;
    for (let i = 1; i <= 6; i++) {
        for (let j = 1; j <= 6; j++) {
            ans = (ans + dp[n][i][j]) % MOD;
        }
    }

    return ans;

    function gcd(a, b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }
};