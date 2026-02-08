const distinctSequences = function(n) {
    const MOD = 1e9 + 7;
    if (n === 1) return 6;

    const dp = Array.from({ length: n + 1 }, () => Array(7).fill(0).map(() => Array(7).fill(0)));

    for (let i = 1; i <= 6; i++) {
        for (let j = 1; j <= 6; j++) {
            if (i !== j && gcd(i, j) === 1) {
                dp[2][i][j] = 1;
            }
        }
    }

    for (let len = 3; len <= n; len++) {
        for (let prev = 1; prev <= 6; prev++) {
            for (let curr = 1; curr <= 6; curr++) {
                if (prev === curr || gcd(prev, curr) !== 1) continue;
                for (let beforePrev = 1; beforePrev <= 6; beforePrev++) {
                    if (beforePrev === curr) continue;
                    dp[len][prev][curr] = (dp[len][prev][curr] + dp[len - 1][beforePrev][prev]) % MOD;
                }
            }
        }
    }

    let res = 0;
    for (let i = 1; i <= 6; i++) {
        for (let j = 1; j <= 6; j++) {
            res = (res + dp[n][i][j]) % MOD;
        }
    }
    return res;
};

function gcd(a, b) {
    if (b === 0) return a;
    return gcd(b, a % b);
}