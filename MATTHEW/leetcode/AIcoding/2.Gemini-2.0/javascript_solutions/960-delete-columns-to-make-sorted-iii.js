var minDeletionSize = function(strs) {
    const n = strs.length;
    const m = strs[0].length;
    const dp = new Array(m).fill(1);

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < i; j++) {
            let sorted = true;
            for (let k = 0; k < n; k++) {
                if (strs[k][j] > strs[k][i]) {
                    sorted = false;
                    break;
                }
            }
            if (sorted) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < m; i++) {
        maxLen = Math.max(maxLen, dp[i]);
    }

    return m - maxLen;
};