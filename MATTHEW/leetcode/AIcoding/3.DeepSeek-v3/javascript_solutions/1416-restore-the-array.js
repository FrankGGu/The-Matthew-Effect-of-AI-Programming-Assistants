var numberOfArrays = function(s, k) {
    const n = s.length;
    const mod = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);
    dp[n] = 1;

    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === '0') {
            dp[i] = 0;
            continue;
        }
        let num = 0;
        for (let j = i; j < n; j++) {
            num = num * 10 + (s.charCodeAt(j) - '0'.charCodeAt(0));
            if (num > k) break;
            dp[i] = (dp[i] + dp[j + 1]) % mod;
        }
    }
    return dp[0];
};