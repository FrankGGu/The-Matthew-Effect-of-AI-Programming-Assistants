var maxPoints = function(points) {
    const m = points.length;
    const n = points[0].length;
    let dp = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        const newDp = new Array(n).fill(0);
        let leftMax = 0;
        for (let j = 0; j < n; j++) {
            leftMax = Math.max(leftMax - 1, dp[j]);
            newDp[j] = leftMax;
        }

        let rightMax = 0;
        for (let j = n - 1; j >= 0; j--) {
            rightMax = Math.max(rightMax - 1, dp[j]);
            newDp[j] = Math.max(newDp[j], rightMax) + points[i][j];
        }

        dp = newDp;
    }

    return Math.max(...dp);
};