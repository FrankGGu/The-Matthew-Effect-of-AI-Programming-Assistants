function dieSimulator(n, rollMax) {
    const MOD = 1000000007;
    const dp = Array.from({ length: n + 1 }, () => Array(7).fill(0));

    for (let j = 1; j <= 6; j++) {
        dp[1][j] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= 6; j++) {
            for (let k = 1; k <= rollMax[j - 1] && k < i; k++) {
                let sum = 0;
                for (let x = 1; x <= 6; x++) {
                    if (x !== j) {
                        sum = (sum + dp[i - k - 1][x]) % MOD;
                    }
                }
                dp[i][j] = (dp[i][j] + sum) % MOD;
            }
        }
    }

    let result = 0;
    for (let j = 1; j <= 6; j++) {
        result = (result + dp[n][j]) % MOD;
    }

    return result;
}