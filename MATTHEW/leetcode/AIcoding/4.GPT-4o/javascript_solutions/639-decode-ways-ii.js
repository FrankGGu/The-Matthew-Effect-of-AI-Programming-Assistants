var numDecodings = function(s) {
    const MOD = 1e9 + 7;
    let n = s.length;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        let oneDigit = parseInt(s[i - 1]);
        if (oneDigit >= 1 && oneDigit <= 9) {
            dp[i] = (dp[i] + dp[i - 1]) % MOD;
        }
        if (i > 1) {
            let twoDigits = parseInt(s.substring(i - 2, i));
            if (twoDigits >= 10 && twoDigits <= 26) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            } else if (s[i - 2] === '1' && oneDigit >= 0 && oneDigit <= 9) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            } else if (s[i - 2] === '2' && oneDigit >= 0 && oneDigit <= 6) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
            }
        }
    }

    return dp[n];
};