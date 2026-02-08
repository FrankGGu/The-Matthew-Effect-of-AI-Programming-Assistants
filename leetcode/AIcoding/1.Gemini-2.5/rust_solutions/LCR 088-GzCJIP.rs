impl Solution {
    pub fn min_cost_climbing_stairs(cost: Vec<i32>) -> i32 {
        let n = cost.len();

        // dp[i] represents the minimum cost to reach step i (and pay its cost).
        // We can optimize space to O(1) by only keeping track of the two previous values.
        // prev2 stores dp[i-2]
        // prev1 stores dp[i-1]

        // Initialize for the first two steps.
        // Since n is guaranteed to be at least 2, cost[0] and cost[1] are always valid.
        let mut prev2 = cost[0]; // Minimum cost to reach step 0
        let mut prev1 = cost[1]; // Minimum cost to reach step 1

        // Iterate from the third step (index 2) up to the last step (index n-1).
        for i in 2..n {
            // The minimum cost to reach the current step 'i' is the cost of step 'i'
            // plus the minimum cost to reach either step 'i-1' or step 'i-2'.
            let current_cost = std::cmp::min(prev1, prev2) + cost[i];

            // Update prev2 and prev1 for the next iteration.
            prev2 = prev1;
            prev1 = current_cost;
        }

        // The final answer is the minimum cost to reach the top of the floor.
        // The top can be reached either from the last step (n-1) or the second to last step (n-2).
        // At the end of the loop:
        // prev1 holds the minimum cost to reach step n-1 (dp[n-1])
        // prev2 holds the minimum cost to reach step n-2 (dp[n-2])
        std::cmp::min(prev1, prev2)
    }
}