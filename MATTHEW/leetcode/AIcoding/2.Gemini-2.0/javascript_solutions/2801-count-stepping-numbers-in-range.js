var countSteppingNumbers = function(low, high) {
    const MOD = 10**9 + 7;

    function count(numStr) {
        const n = numStr.length;
        let dp = Array(n + 1).fill(null).map(() => Array(10).fill(0));
        let sum = Array(n + 1).fill(0);

        for (let i = 1; i <= 9; i++) {
            dp[1][i] = 1;
        }
        sum[1] = 9;

        for (let i = 2; i <= n; i++) {
            for (let j = 0; j <= 9; j++) {
                if (j > 0) dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                if (j < 9) dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
            }
            for (let j = 0; j <= 9; j++) {
                sum[i] = (sum[i] + dp[i][j]) % MOD;
            }
        }

        let ans = 0;
        let prevDigit = -1;
        for (let i = 0; i < n; i++) {
            let digit = parseInt(numStr[i]);
            for (let j = (i === 0 ? 1 : 0); j < digit; j++) {
                if (Math.abs(j - prevDigit) === 1 || prevDigit === -1) {
                    ans = (ans + dp[n - i][j]) % MOD;
                }
            }
            if (Math.abs(digit - prevDigit) !== 1 && prevDigit !== -1) {
                break;
            }
            prevDigit = digit;
            if (i === n - 1) {
                ans = (ans + 1) % MOD;
            }
        }

        for (let i = 1; i < n; i++) {
            ans = (ans - sum[i] + MOD) % MOD;
        }

        return ans;
    }

    let ans = (count(high) - count(low) + MOD) % MOD;
    let isStepping = true;
    for (let i = 1; i < low.length; i++) {
        if (Math.abs(parseInt(low[i]) - parseInt(low[i - 1])) !== 1) {
            isStepping = false;
            break;
        }
    }
    if (isStepping) {
        ans = (ans + 1) % MOD;
    }

    return ans;
};