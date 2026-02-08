var countSubstrings = function(s) {
    let n = s.length;
    let count = 0;
    let dp = Array(n).fill(null).map(() => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        dp[i][i] = true;
        count++;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            dp[i][i + 1] = true;
            count++;
        }
    }

    for (let len = 3; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            if (s[i] === s[j] && dp[i + 1][j - 1]) {
                dp[i][j] = true;
                count++;
            }
        }
    }

    return count;
};