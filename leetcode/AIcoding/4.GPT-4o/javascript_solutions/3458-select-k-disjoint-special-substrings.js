var maxSpecialSubstring = function(s, k) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const index = new Array(n + 1).fill(0);
    let maxLen = 0;

    for (let i = 1; i <= n; i++) {
        if (s[i - 1] === '1') {
            dp[i] = dp[i - 1] + 1;
        } else {
            dp[i] = 0;
        }
        index[dp[i]] = i;
    }

    for (let len = 1; len <= n; len++) {
        if (index[len] > 0) {
            maxLen = Math.max(maxLen, len * k);
        }
    }

    return maxLen;
};