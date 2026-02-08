var maximumBobPoints = function(moles) {
    const n = moles.length;
    moles.sort((a, b) => a[0] - b[0]);
    const dp = new Array(n).fill(0);
    let maxPoints = 0;

    for (let i = 0; i < n; i++) {
        dp[i] = moles[i][2];
        for (let j = 0; j < i; j++) {
            if (moles[j][0] + Math.abs(moles[i][1] - moles[j][1]) <= moles[i][0]) {
                dp[i] = Math.max(dp[i], dp[j] + moles[i][2]);
            }
        }
        maxPoints = Math.max(maxPoints, dp[i]);
    }

    return maxPoints;
};