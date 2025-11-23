var numPermsDISequence = function(S) {
    const MOD = 1e9 + 7;
    const n = S.length;
    let dp = Array(n + 1).fill(1);

    for (let i = 0; i < n; i++) {
        const next = Array(n + 1).fill(0);
        if (S[i] === 'D') {
            let sum = 0;
            for (let j = n - i - 1; j >= 0; j--) {
                sum = (sum + dp[j + 1]) % MOD;
                next[j] = sum;
            }
        } else {
            let sum = 0;
            for (let j = 0; j <= n - i; j++) {
                next[j] = sum;
                sum = (sum + dp[j]) % MOD;
            }
        }
        dp = next;
    }

    return dp[0];
};