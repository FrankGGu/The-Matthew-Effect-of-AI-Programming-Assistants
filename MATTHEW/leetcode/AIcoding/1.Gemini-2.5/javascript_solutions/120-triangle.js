var minimumTotal = function(triangle) {
    const n = triangle.length;
    if (n === 0) {
        return 0;
    }

    // Initialize dp array with the last row of the triangle
    // This array will store the minimum path sum to reach the current position
    // from the bottom up.
    const dp = Array(n);
    for (let i = 0; i < n; i++) {
        dp[i] = triangle[n - 1][i];
    }

    // Iterate from the second to last row up to the first row
    for (let i = n - 2; i >= 0; i--) {
        // For each element in the current row
        for (let j = 0; j <= i; j++) {
            // The minimum path sum to reach triangle[i][j] is triangle[i][j]
            // plus the minimum of the two adjacent elements in the row below (which are already processed in dp)
            dp[j] = triangle[i][j] + Math.min(dp[j], dp[j + 1]);
        }
    }

    // The minimum total path sum will be at the top of the dp array (index 0)
    return dp[0];
};