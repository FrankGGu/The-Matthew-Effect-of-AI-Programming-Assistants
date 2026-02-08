const numDecodings = function(s) {
    const MOD = 1e9 + 7;
    const n = s.length;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        const curr = s[i - 1];

        // Single digit
        if (curr === '*') {
            dp[i] = (dp[i] + dp[i - 1] * 9) % MOD;
        } else if (curr !== '0') {
            dp[i] = (dp[i] + dp[i - 1]) % MOD;
        }

        if (i >= 2) {
            const prev = s[i - 2];

            // Two digits
            if (prev === '*') {
                if (curr === '*') {
                    dp[i] = (dp[i] + dp[i - 2] * 15) % MOD;
                } else if (curr <= '6') {
                    dp[i] = (dp[i] + dp[i - 2] * 2) % MOD;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            } else if (prev === '1') {
                if (curr === '*') {
                    dp[i] = (dp[i] + dp[i - 2] * 9) % MOD;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            } else if (prev === '2') {
                if (curr === '*') {
                    dp[i] = (dp[i] + dp[i - 2] * 6) % MOD;
                } else if (curr <= '6') {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            }
        }
    }

    return dp[n];
};