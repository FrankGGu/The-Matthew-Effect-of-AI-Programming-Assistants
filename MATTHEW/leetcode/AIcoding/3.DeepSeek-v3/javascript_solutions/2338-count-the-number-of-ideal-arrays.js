const MOD = 1e9 + 7;

var idealArrays = function(n, maxValue) {
    const maxK = Math.min(20, Math.log2(maxValue) + 1);
    const dp = Array.from({ length: maxValue + 1 }, () => Array(maxK + 1).fill(0));
    const comb = Array.from({ length: n + 1 }, () => Array(maxK + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        comb[i][0] = 1;
        if (i <= maxK) comb[i][i] = 1;
        for (let j = 1; j < Math.min(i, maxK + 1); j++) {
            comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % MOD;
        }
    }

    for (let i = 1; i <= maxValue; i++) {
        dp[i][1] = 1;
    }

    for (let i = 2; i <= maxValue; i++) {
        for (let j = 2; j <= maxK; j++) {
            for (let k = 2; k * i <= maxValue; k++) {
                dp[k * i][j] = (dp[k * i][j] + dp[i][j-1]) % MOD;
            }
        }
    }

    let res = 0;
    for (let i = 1; i <= maxValue; i++) {
        for (let j = 1; j <= maxK; j++) {
            res = (res + dp[i][j] * comb[n-1][j-1]) % MOD;
        }
    }

    return res;
};