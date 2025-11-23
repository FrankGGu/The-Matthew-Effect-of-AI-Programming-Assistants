var minimumStrings = function(source, target) {
    const n = source.length;
    const m = target.length;
    const dp = new Array(m + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < m; i++) {
        if (dp[i] === Infinity) continue;
        for (let j = 0; j < n; j++) {
            let k = 0;
            while (i + k < m && j + k < n && source[j + k] === target[i + k]) {
                k++;
            }
            if (k > 0) {
                if (dp[i + k] > dp[i] + 1) {
                    dp[i + k] = dp[i] + 1;
                }
            }
        }
    }

    return dp[m] === Infinity ? -1 : dp[m];
};