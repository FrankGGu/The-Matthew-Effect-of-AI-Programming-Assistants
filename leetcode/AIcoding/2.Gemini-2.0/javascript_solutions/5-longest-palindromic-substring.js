var longestPalindrome = function(s) {
    if (!s) return "";
    let n = s.length;
    let dp = Array(n).fill(null).map(() => Array(n).fill(false));
    let start = 0;
    let maxLength = 1;

    for (let i = 0; i < n; i++) {
        dp[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            dp[i][i + 1] = true;
            start = i;
            maxLength = 2;
        }
    }

    for (let k = 3; k <= n; k++) {
        for (let i = 0; i <= n - k; i++) {
            let j = i + k - 1;
            if (s[i] === s[j] && dp[i + 1][j - 1]) {
                dp[i][j] = true;
                if (k > maxLength) {
                    start = i;
                    maxLength = k;
                }
            }
        }
    }

    return s.substring(start, start + maxLength);
};