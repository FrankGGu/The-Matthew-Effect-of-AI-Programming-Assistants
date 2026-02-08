use std::cmp::min;

impl Solution {
    pub fn connect_two_groups(cost: Vec<Vec<i32>>) -> i32 {
        let n = cost.len();
        let m = cost[0].len();

        // Use a large enough value to represent infinity, to prevent overflow during additions.
        let inf = i32::MAX / 2; 

        // Step 1: Precompute the minimum cost to connect each Group 2 point to ANY Group 1 point.
        // This is needed for Group 2 points that are not covered by any Group 1 point's primary connection.
        let mut min_cost_for_g2_point = vec![inf; m];
        for j in 0..m {
            for i in 0..n {
                min_cost_for_g2_point[j] = min(min_cost_for_g2_point[j], cost[i][j]);
            }
        }

        // Step 2: Dynamic Programming
        // dp_prev[mask] stores the minimum cost to connect the first 'i' Group 1 points,
        // such that the Group 2 points covered by these 'i' connections are represented by 'mask'.
        // We use two DP arrays (dp_prev and dp_curr) to optimize space, only keeping track of the current and previous states.
        let mut dp_prev = vec![inf; 1 << m];
        dp_prev[0] = 0; // Base case: 0 Group 1 points connected, 0 Group 2 points covered, cost is 0.

        for i in 0..n { // Iterate through each Group 1 point (from 0 to n-1)
            let mut dp_curr = vec![inf; 1 << m]; // Initialize dp_curr for the (i+1)-th Group 1 point
            for prev_mask in 0..(1 << m) { // Iterate through all possible masks of Group 2 points from the previous state
                if dp_prev[prev_mask] == inf {
                    continue; // Skip if this state is unreachable
                }
                for j in 0..m { // Try connecting the current Group 1 point 'i' to Group 2 point 'j'
                    let new_mask = prev_mask | (1 << j); // Update the mask to include Group 2 point 'j'
                    dp_curr[new_mask] = min(dp_curr[new_mask], dp_prev[prev_mask] + cost[i][j]);
                }
            }
            dp_prev = dp_curr; // Move to the next Group 1 point by making dp_curr the new dp_prev
        }

        // After the loop, dp_prev holds the minimum costs for connecting all 'n' Group 1 points
        // (each exactly once), with 'mask' representing the set of Group 2 points covered by these connections.
        // Now, we need to ensure that ALL Group 2 points are covered.
        // For any Group 2 point 'k' not covered in a given 'mask', we add its minimum connection cost (precomputed in min_cost_for_g2_point).
        let mut min_total_cost = inf;
        for mask in 0..(1 << m) {
            if dp_prev[mask] == inf {
                continue; // Skip unreachable states
            }
            let mut current_cost = dp_prev[mask];
            for k in 0..m {
                if (mask & (1 << k)) == 0 { // If Group 2 point 'k' is not covered by the 'n' primary connections
                    current_cost += min_cost_for_g2_point[k]; // Add the minimum cost to cover it
                }
            }
            min_total_cost = min(min_total_cost, current_cost);
        }

        min_total_cost
    }
}