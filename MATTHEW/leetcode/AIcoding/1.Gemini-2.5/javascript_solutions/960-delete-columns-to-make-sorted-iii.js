var minDeletionSize = function(strs) {
    const M = strs.length;
    const L = strs[0].length;

    const dp = new Array(L).fill(1);

    let maxKept = 1;

    for (let j = 1; j < L; j++) {
        for (let k = 0; k < j; k++) {
            let canFollow = true;
            for (let i = 0; i < M; i++) {
                if (strs[i][k] > strs[i][j]) {
                    canFollow = false;
                    break;
                }
            }

            if (canFollow) {
                dp[j] = Math.max(dp[j], 1 + dp[k]);
            }
        }
        maxKept = Math.max(maxKept, dp[j]);
    }

    return maxKept;
};