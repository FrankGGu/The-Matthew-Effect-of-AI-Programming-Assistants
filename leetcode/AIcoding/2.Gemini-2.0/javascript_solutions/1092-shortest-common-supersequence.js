var shortestCommonSupersequence = function(str1, str2) {
    const m = str1.length;
    const n = str2.length;
    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (str1[i - 1] === str2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    let i = m;
    let j = n;
    let result = "";

    while (i > 0 || j > 0) {
        if (i > 0 && j > 0 && str1[i - 1] === str2[j - 1]) {
            result = str1[i - 1] + result;
            i--;
            j--;
        } else if (i > 0 && (j === 0 || dp[i - 1][j] >= dp[i][j - 1])) {
            result = str1[i - 1] + result;
            i--;
        } else {
            result = str2[j - 1] + result;
            j--;
        }
    }

    return result;
};