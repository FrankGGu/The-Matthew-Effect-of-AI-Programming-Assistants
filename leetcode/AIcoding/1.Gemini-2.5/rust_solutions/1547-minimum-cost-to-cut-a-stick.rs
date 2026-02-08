impl Solution {
    pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
        let mut all_cuts = vec![0];
        all_cuts.extend(cuts.into_iter());
        all_cuts.push(n);
        all_cuts.sort_unstable();

        let m = all_cuts.len();
        // dp[i][j] stores the minimum cost to cut the stick segment
        // from all_cuts[i] to all_cuts[j], considering only cuts
        // that are strictly between all_cuts[i] and all_cuts[j].
        let mut dp = vec![vec![0; m]; m];

        // Iterate over the length of the sub-problem (number of segments in all_cuts array - 1)
        // A length of 2 means we are considering a stick segment defined by three cut points:
        // all_cuts[i], all_cuts[i+1], all_cuts[i+2].
        // The actual stick length is all_cuts[j] - all_cuts[i].
        for length in 2..m {
            // Iterate over the starting index 'i' of the sub-problem
            for i in 0..(m - length) {
                let j = i + length; // 'j' is the ending index of the sub-problem

                // Initialize min_cost_for_segment to a very large value
                // This will store the minimum cost from recursively solving subproblems
                let mut min_cost_for_segment = i32::MAX;

                // Iterate through all possible intermediate cut points 'k'
                // 'k' represents the index of the cut in the 'all_cuts' array
                // The cut at all_cuts[k] splits the stick [all_cuts[i], all_cuts[j]]
                // into two sub-sticks: [all_cuts[i], all_cuts[k]] and [all_cuts[k], all_cuts[j]].
                for k in (i + 1)..j {
                    min_cost_for_segment = min_cost_for_segment.min(dp[i][k] + dp[k][j]);
                }

                // The cost for cutting the stick segment [all_cuts[i], all_cuts[j]]
                // is its current length plus the minimum cost to cut its sub-segments.
                // The current length is (all_cuts[j] - all_cuts[i]).
                // If min_cost_for_segment is still MAX, it implies no valid intermediate cuts were found,
                // which should only happen for length < 2, but our loop starts at length 2.
                // For length 2, k will be i+1, and dp[i][i+1] and dp[i+1][i+2] are 0 (base cases).
                // So min_cost_for_segment will be 0 for length 2.
                dp[i][j] = (all_cuts[j] - all_cuts[i]) + min_cost_for_segment;
            }
        }

        // The final answer is the minimum cost to cut the entire stick,
        // which is represented by the segment from all_cuts[0] to all_cuts[m-1].
        dp[0][m - 1]
    }
}