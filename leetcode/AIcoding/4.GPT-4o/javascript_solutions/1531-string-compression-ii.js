var getLengthOfOptimalCompression = function(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j <= k; j++) {
            for (let len = 1; len + i <= n; len++) {
                const nextJ = j + (len - 1) - count(s, i, len);
                if (nextJ >= 0) {
                    dp[i + len][nextJ] = Math.min(dp[i + len][nextJ], dp[i][j] + getLength(len));
                }
            }
        }
    }

    let result = Infinity;
    for (let j = 0; j <= k; j++) {
        result = Math.min(result, dp[n][j]);
    }

    return result;
};

function count(s, i, len) {
    let count = 0;
    for (let j = i; j < i + len; j++) {
        count++;
    }
    return count;
}

function getLength(len) {
    if (len === 1) return 1;
    return 1 + Math.floor(Math.log10(len)) + 1;
}