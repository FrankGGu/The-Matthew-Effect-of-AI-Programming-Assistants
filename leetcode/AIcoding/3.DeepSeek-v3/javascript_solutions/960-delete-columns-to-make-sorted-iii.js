var minDeletionSize = function(strs) {
    const m = strs.length;
    const n = strs[0].length;
    const dp = new Array(n).fill(1);
    let max = 1;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            let valid = true;
            for (let k = 0; k < m; k++) {
                if (strs[k][j] > strs[k][i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
        max = Math.max(max, dp[i]);
    }

    return n - max;
};