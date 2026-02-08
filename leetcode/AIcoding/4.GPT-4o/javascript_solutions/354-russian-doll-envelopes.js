var maxEnvelopes = function(envelopes) {
    envelopes.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    const dp = [];
    for (const [_, h] of envelopes) {
        let left = 0, right = dp.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] < h) left = mid + 1;
            else right = mid;
        }
        dp[left] = h;
    }
    return dp.length;
};