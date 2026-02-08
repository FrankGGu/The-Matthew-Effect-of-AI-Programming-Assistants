var maxTaxiEarnings = function(n, rides) {
    // dp[i] will store the maximum earnings we can get if we consider rides that end at or before point i.
    // The array is of size n+1 to cover points from 0 to n.
    const dp = new Array(n + 1).fill(0);

    // Group rides by their end points for efficient lookup.
    // ridesEndingAt[i] will be a list of rides that end exactly at point i.
    const ridesEndingAt = new Array(n + 1).fill(null).map(() => []);

    // Populate ridesEndingAt, only considering rides that end within the road's points (1 to n).
    for (const [start, end, tip] of rides) {
        if (end <= n) {
            ridesEndingAt[end].push([start, end, tip]);
        }
    }

    // Iterate through each point from 1 to n.
    for (let i = 1; i <= n; i++) {
        // Option 1: Do not take any ride that ends at point i.
        // In this case, the maximum earnings are the same as the maximum earnings up to point i-1.
        dp[i] = dp[i - 1];

        // Option 2: Consider taking rides that end exactly at point i.
        for (const [start, end, tip] of ridesEndingAt[i]) {
            // Calculate earnings for the current ride.
            const currentRideEarnings = end - start + tip;

            // If we take this ride, we add its earnings to the maximum earnings
            // we could have accumulated up to the point where this ride started (dp[start]).
            // We take the maximum of the current dp[i] and this new possibility.
            // dp[start] represents the maximum earnings before this ride began.
            dp[i] = Math.max(dp[i], dp[start] + currentRideEarnings);
        }
    }

    // The maximum earnings up to point n will be our final answer.
    return dp[n];
};