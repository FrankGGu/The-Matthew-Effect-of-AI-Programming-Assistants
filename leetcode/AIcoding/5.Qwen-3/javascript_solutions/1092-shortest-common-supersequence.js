function shortestCommonSupersequence(s1, s2) {
    const m = s1.length;
    const n = s2.length;
    const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (s1[i - 1] === s2[j - 1]) {
                dp[i][j] = 1 + dp[i - 1][j - 1];
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    let i = m, j = n;
    const result = [];

    while (i > 0 && j > 0) {
        if (s1[i - 1] === s2[j - 1]) {
            result.unshift(s1[i - 1]);
            i--;
            j--;
        } else if (dp[i - 1][j] > dp[i][j - 1]) {
            result.unshift(s1[i - 1]);
            i--;
        } else {
            result.unshift(s2[j - 1]);
            j--;
        }
    }

    while (i > 0) {
        result.unshift(s1[i - 1]);
        i--;
    }

    while (j > 0) {
        result.unshift(s2[j - 1]);
        j--;
    }

    return result.join('');
}