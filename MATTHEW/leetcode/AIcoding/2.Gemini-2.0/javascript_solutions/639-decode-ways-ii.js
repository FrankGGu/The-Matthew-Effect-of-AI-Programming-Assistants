var numDecodings = function(s) {
    const n = s.length;
    const MOD = 1000000007;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        const oneDigit = s.substring(i - 1, i);
        const twoDigits = i > 1 ? s.substring(i - 2, i) : "";

        if (oneDigit === '*') {
            dp[i] = (dp[i] + 9 * dp[i - 1]) % MOD;
        } else if (oneDigit !== '0') {
            dp[i] = (dp[i] + dp[i - 1]) % MOD;
        }

        if (i > 1) {
            if (twoDigits === '**') {
                dp[i] = (dp[i] + 15 * dp[i - 2]) % MOD;
            } else if (twoDigits.charAt(0) === '*') {
                const secondDigit = parseInt(twoDigits.charAt(1));
                if (secondDigit >= 0 && secondDigit <= 6) {
                    dp[i] = (dp[i] + 2 * dp[i - 2]) % MOD;
                } else {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            } else if (twoDigits.charAt(1) === '*') {
                const firstDigit = parseInt(twoDigits.charAt(0));
                if (firstDigit === 1) {
                    dp[i] = (dp[i] + 9 * dp[i - 2]) % MOD;
                } else if (firstDigit === 2) {
                    dp[i] = (dp[i] + 6 * dp[i - 2]) % MOD;
                }
            } else {
                const num = parseInt(twoDigits);
                if (num >= 10 && num <= 26) {
                    dp[i] = (dp[i] + dp[i - 2]) % MOD;
                }
            }
        }
    }

    return dp[n];
};