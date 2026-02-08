var maxPoints = function(points) {
    const m = points.length;
    const n = points[0].length;
    let dp = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        const newDp = new Array(n).fill(0);
        let leftMax = new Array(n).fill(0);
        let rightMax = new Array(n).fill(0);

        leftMax[0] = dp[0];
        for (let j = 1; j < n; j++) {
            leftMax[j] = Math.max(leftMax[j - 1] - 1, dp[j]);
        }

        rightMax[n - 1] = dp[n - 1];
        for (let j = n - 2; j >= 0; j--) {
            rightMax[j] = Math.max(rightMax[j + 1] - 1, dp[j]);
        }

        for (let j = 0; j < n; j++) {
            newDp[j] = points[i][j] + Math.max(leftMax[j], rightMax[j]);
        }

        dp = newDp;
    }

    return Math.max(...dp);
};