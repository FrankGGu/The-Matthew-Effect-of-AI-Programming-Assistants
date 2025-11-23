var maxPoints = function(points) {
    const m = points.length;
    const n = points[0].length;

    let prev_dp = points[0];

    for (let r = 1; r < m; r++) {
        const current_dp = new Array(n).fill(0);

        let max_left = -Infinity;
        for (let c = 0; c < n; c++) {
            max_left = Math.max(max_left, prev_dp[c] + c);
            current_dp[c] = points[r][c] + max_left - c;
        }

        let max_right = -Infinity;
        for (let c = n - 1; c >= 0; c--) {
            max_right = Math.max(max_right, prev_dp[c] - c);
            current_dp[c] = Math.max(current_dp[c], points[r][c] + max_right + c);
        }

        prev_dp = current_dp;
    }

    let max_total_points = -Infinity;
    for (let c = 0; c < n; c++) {
        max_total_points = Math.max(max_total_points, prev_dp[c]);
    }

    return max_total_points;
};