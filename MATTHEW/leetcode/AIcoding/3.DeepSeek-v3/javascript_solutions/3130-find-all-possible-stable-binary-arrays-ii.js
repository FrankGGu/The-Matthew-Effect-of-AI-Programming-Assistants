var numberOfStableArrays = function(zero, one, limit) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: zero + 1 }, () => 
        Array.from({ length: one + 1 }, () => 
            Array(2).fill(0)
        )
    );

    if (zero > 0) dp[1][0][0] = 1;
    if (one > 0) dp[0][1][1] = 1;

    for (let z = 0; z <= zero; z++) {
        for (let o = 0; o <= one; o++) {
            if (z + o <= 1) continue;

            if (z > 0) {
                dp[z][o][0] = (dp[z - 1][o][0] + dp[z - 1][o][1]) % MOD;
                if (z > limit) {
                    dp[z][o][0] = (dp[z][o][0] - dp[z - limit - 1][o][1] + MOD) % MOD;
                }
            }

            if (o > 0) {
                dp[z][o][1] = (dp[z][o - 1][0] + dp[z][o - 1][1]) % MOD;
                if (o > limit) {
                    dp[z][o][1] = (dp[z][o][1] - dp[z][o - limit - 1][0] + MOD) % MOD;
                }
            }
        }
    }

    return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
};