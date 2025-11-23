const MOD = 1e9 + 7;

function numberOfCombinations(num) {
    if (num[0] === '0') return 0;
    const n = num.length;
    const lcp = Array(n + 1).fill().map(() => Array(n + 1).fill(0));
    for (let i = n - 1; i >= 0; --i) {
        for (let j = n - 1; j >= 0; --j) {
            if (num[i] === num[j]) {
                lcp[i][j] = 1 + lcp[i + 1][j + 1];
            } else {
                lcp[i][j] = 0;
            }
        }
    }
    const dp = Array(n + 1).fill().map(() => Array(n + 1).fill(0));
    const prefix = Array(n + 1).fill().map(() => Array(n + 1).fill(0));
    for (let j = 1; j <= n; ++j) {
        dp[0][j] = 1;
        prefix[0][j] = prefix[0][j - 1] + dp[0][j];
    }
    for (let i = 1; i <= n; ++i) {
        if (num[i - 1] === '0') continue;
        for (let j = i; j <= n; ++j) {
            const len = j - i + 1;
            let prevStart = i - 1 - (len - 1);
            if (prevStart < 0) prevStart = 0;
            let count = 0;
            if (prevStart <= i - 1) {
                count = (prefix[i - 1][i - 1] - (prevStart === 0 ? 0 : prefix[i - 1][prevStart - 1]) + MOD) % MOD;
            }
            if (prevStart === i - len) {
                const common = lcp[prevStart][i];
                if (common < len && num[prevStart + common] > num[i + common]) {
                    count = (count - dp[prevStart][i - 1] + MOD) % MOD;
                }
            }
            dp[i][j] = count;
            prefix[i][j] = (prefix[i][j - 1] + dp[i][j]) % MOD;
        }
    }
    let res = 0;
    for (let i = 1; i <= n; ++i) {
        res = (res + dp[i][n]) % MOD;
    }
    return res;
}