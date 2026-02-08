var maxPoints = function(points) {
    const m = points.length;
    const n = points[0].length;

    let dp = new Array(n).fill(0);
    for (let j = 0; j < n; j++) {
        dp[j] = points[0][j];
    }

    for (let i = 1; i < m; i++) {
        let left = new Array(n).fill(0);
        let right = new Array(n).fill(0);

        left[0] = dp[0];
        for (let j = 1; j < n; j++) {
            left[j] = Math.max(left[j - 1] - 1, dp[j]);
        }

        right[n - 1] = dp[n - 1];
        for (let j = n - 2; j >= 0; j--) {
            right[j] = Math.max(right[j + 1] - 1, dp[j]);
        }

        for (let j = 0; j < n; j++) {
            dp[j] = Math.max(left[j], right[j]) + points[i][j];
        }
    }

    let max = 0;
    for (let j = 0; j < n; j++) {
        max = Math.max(max, dp[j]);
    }

    return max;
};