var maximizeWin = function(prizePositions, k) {
    const n = prizePositions.length;
    const dp = new Array(n + 1).fill(0);
    let res = 0;
    let left = 0;

    for (let right = 0; right < n; right++) {
        while (prizePositions[right] - prizePositions[left] > k) {
            left++;
        }
        const current = right - left + 1;
        dp[right + 1] = Math.max(dp[right], current);
        res = Math.max(res, current + dp[left]);
    }

    return res;
};