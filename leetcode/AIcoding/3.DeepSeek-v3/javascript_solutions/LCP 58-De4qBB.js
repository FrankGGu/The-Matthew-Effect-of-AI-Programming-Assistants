var pileBox = function(box) {
    box.sort((a, b) => a[0] - b[0]);
    const n = box.length;
    const dp = new Array(n).fill(0);
    dp[0] = box[0][2];
    let maxHeight = dp[0];

    for (let i = 1; i < n; i++) {
        dp[i] = box[i][2];
        for (let j = 0; j < i; j++) {
            if (box[j][0] < box[i][0] && box[j][1] < box[i][1] && box[j][2] < box[i][2]) {
                dp[i] = Math.max(dp[i], dp[j] + box[i][2]);
            }
        }
        maxHeight = Math.max(maxHeight, dp[i]);
    }

    return maxHeight;
};