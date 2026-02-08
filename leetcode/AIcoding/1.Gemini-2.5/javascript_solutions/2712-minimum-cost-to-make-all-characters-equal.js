var minimumCost = function(s) {
    const n = s.length;

    // dp0[i] stores the minimum cost to make s[0...i] all '0's.
    // dp1[i] stores the minimum cost to make s[0...i] all '1's.
    // We can optimize space by only storing the previous values.
    let prev_dp0 = 0;
    let prev_dp1 = 0;

    // Base case for i = 0
    // If s[0] is '0', cost to make it '0' is 0. Cost to make it '1' is 0+1.
    // If s[0] is '1', cost to make it '0' is 0+1. Cost to make it '1' is 0.
    if (s[0] === '0') {
        prev_dp0 = 0;
        prev_dp1 = 1;
    } else { // s[0] === '1'
        prev_dp0 = 1;
        prev_dp1 = 0;
    }

    // Iterate from i = 1 to n-1
    for (let i = 1; i < n; i++) {
        let current_dp0 = 0;
        let current_dp1 = 0;

        // Calculate current_dp0 (cost to make s[0...i] all '0's)
        // This means s[i-1] must have been '0' (from prev_dp0) and s[i] must become '0'.
        // If s[i] is already '0', no additional cost.
        // If s[i] is '1', we need to flip it. The cost for flipping s[i] is (i+1).
        // We assume we use operation 1 (flip s[i] only), as it's locally optimal and doesn't affect future characters.
        if (s[i] === '0') {
            current_dp0 = prev_dp0;
        } else { // s[i] === '1'
            current_dp0 = prev_dp0 + (i + 1);
        }

        // Calculate current_dp1 (cost to make s[0...i] all '1's)
        // This means s[i-1] must have been '1' (from prev_dp1) and s[i] must become '1'.
        // If s[i] is already '1', no additional cost.
        // If s[i] is '0', we need to flip it. The cost for flipping s[i] is (i+1).
        if (s[i] === '1') {
            current_dp1 = prev_dp1;
        } else { // s[i] === '0'
            current_dp1 = prev_dp1 + (i + 1);
        }

        // Update previous values for the next iteration
        prev_dp0 = current_dp0;
        prev_dp1 = current_dp1;
    }

    // The minimum cost is the minimum of making the entire string all '0's or all '1's.
    return Math.min(prev_dp0, prev_dp1);
};