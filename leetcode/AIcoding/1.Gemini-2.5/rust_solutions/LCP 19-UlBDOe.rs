impl Solution {
    pub fn minimum_operations(leaves: String) -> i32 {
        let n = leaves.len();
        let leaves_chars: Vec<char> = leaves.chars().collect();

        // dp[state] represents the minimum operations to reach a certain state
        // state 0: all 'r's (first part of r...y...r)
        // state 1: 'r...y' (first two parts)
        // state 2: 'r...y...r' (all three parts)

        // Using space optimization: we only need the values from the previous index (i-1)
        // to calculate the current index (i).
        // dp0_prev, dp1_prev, dp2_prev store values for index i-1.
        // dp0_curr, dp1_curr, dp2_curr store values for index i.

        // Initialize with a large value for states that are not yet reachable or are impossible.
        // u32::MAX serves as infinity.
        const INF: u32 = std::u32::MAX;

        let mut dp0_prev: u32;
        let mut dp1_prev: u32 = INF; // State 1 requires at least one 'r' and one 'y', so not possible at index 0.
        let mut dp2_prev: u32 = INF; // State 2 requires at least one 'r', one 'y', one 'r', so not possible at index 0.

        // Base case for i = 0
        // dp[0][0]: The first leaf must be 'r'. Cost is 1 if it's 'y', 0 if it's 'r'.
        dp0_prev = if leaves_chars[0] == 'y' { 1 } else { 0 };

        // Iterate from the second leaf (index 1) up to the last leaf (n-1)
        for i in 1..n {
            // Cost to change the current leaf to 'r'
            let cost_to_r = if leaves_chars[i] == 'y' { 1 } else { 0 };
            // Cost to change the current leaf to 'y'
            let cost_to_y = if leaves_chars[i] == 'r' { 1 } else { 0 };

            let dp0_curr: u32;
            let dp1_curr: u32;
            let dp2_curr: u32;

            // Transition for state 0 (all 'r's)
            // To make leaves[0...i] all 'r's, leaves[0...i-1] must have been all 'r's,
            // and then we add the cost to make leaves[i] an 'r'.
            dp0_curr = dp0_prev + cost_to_r;

            // Transition for state 1 ('r...y')
            // To make leaves[0...i] 'r...y':
            // 1. leaves[0...i-1] was all 'r's (dp0_prev), and leaves[i] becomes 'y' (starting the 'y' part).
            // 2. leaves[0...i-1] was 'r...y' (dp1_prev), and leaves[i] continues to be 'y'.
            // We take the minimum of these two possibilities.
            dp1_curr = std::cmp::min(dp0_prev, dp1_prev) + cost_to_y;

            // Transition for state 2 ('r...y...r')
            // To make leaves[0...i] 'r...y...r':
            // 1. leaves[0...i-1] was 'r...y' (dp1_prev), and leaves[i] becomes 'r' (starting the final 'r' part).
            // 2. leaves[0...i-1] was 'r...y...r' (dp2_prev), and leaves[i] continues to be 'r'.
            // We take the minimum of these two possibilities.
            // This state is only valid if dp1_prev was reachable (i.e., not INF).
            dp2_curr = std::cmp::min(dp1_prev, dp2_prev) + cost_to_r;

            // Update the previous states for the next iteration
            dp0_prev = dp0_curr;
            dp1_prev = dp1_curr;
            dp2_prev = dp2_curr;
        }

        // The final answer is the minimum operations to reach state 2 at the last leaf.
        dp2_prev as i32
    }
}