var minimumOperations = function(leaves) {
    const n = leaves.length;

    // dp0: minimum operations to make leaves[0...i] all 'r'
    // dp1: minimum operations to make leaves[0...i] 'r...ry...y'
    // dp2: minimum operations to make leaves[0...i] 'r...ry...yr...r'

    // Initialize for i = 0
    // If leaves[0] is 'y', we need 1 operation to make it 'r'. Otherwise 0.
    let dp0 = (leaves[0] === 'y' ? 1 : 0);
    // It's impossible to form 'ry' or 'ryr' pattern with only one leaf.
    let dp1 = Infinity;
    let dp2 = Infinity;

    for (let i = 1; i < n; i++) {
        const isRed = (leaves[i] === 'r');
        const costToMakeRed = isRed ? 0 : 1; // Cost to change leaves[i] to 'r'
        const costToMakeYellow = isRed ? 1 : 0; // Cost to change leaves[i] to 'y'

        // Calculate new dp values for the current index i
        let new_dp0 = dp0 + costToMakeRed;
        // To form 'r...ry...y' ending at i:
        // Either extend 'r...ry...y' from i-1 (dp1) and make leaves[i] 'y',
        // or transition from 'r...r' (dp0) to 'y' section at leaves[i].
        let new_dp1 = Math.min(dp0, dp1) + costToMakeYellow;
        // To form 'r...ry...yr...r' ending at i:
        // Either extend 'r...ry...yr...r' from i-1 (dp2) and make leaves[i] 'r',
        // or transition from 'r...ry...y' (dp1) to 'r' section at leaves[i].
        let new_dp2 = Math.min(dp1, dp2) + costToMakeRed;

        // Update dp values for the next iteration
        dp0 = new_dp0;
        dp1 = new_dp1;
        dp2 = new_dp2;
    }

    // The final answer is the minimum operations to form 'r...ry...yr...r' ending at n-1
    return dp2;
};