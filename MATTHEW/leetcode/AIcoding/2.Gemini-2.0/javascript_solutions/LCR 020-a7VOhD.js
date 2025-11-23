var countSubstrings = function(s) {
    let n = s.length;
    let count = 0;
    let dp = Array(n).fill(null).map(() => Array(n).fill(false));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i; j < n; j++) {
            if (s[i] === s[j]) {
                if (j - i <= 2 || dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                    count++;
                }
            }
        }
    }

    return count;
};