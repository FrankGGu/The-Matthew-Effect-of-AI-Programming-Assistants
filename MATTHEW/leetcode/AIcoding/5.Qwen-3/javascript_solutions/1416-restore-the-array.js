function numberOfWays(s, k) {
    const n = s.length;
    const mod = 10 ** 9 + 7;

    const dp = Array.from({ length: n }, () => Array(k + 1).fill(0));
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') continue;
        dp[i][1] = 1;
    }

    for (let len = 2; len <= k; len++) {
        for (let i = 0; i < n; i++) {
            if (s[i] === '0') continue;
            for (let j = 0; j < i; j++) {
                if (s[j] === '0') continue;
                dp[i][len] = (dp[i][len] + dp[j][len - 1]) % mod;
            }
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result = (result + dp[i][k]) % mod;
    }
    return result;
}