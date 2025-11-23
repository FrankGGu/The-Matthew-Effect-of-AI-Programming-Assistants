impl Solution {
    pub fn dice_probabilities(n: i32) -> Vec<f64> {
        let n_usize = n as usize;
        let max_sum = 6 * n_usize;

        let mut dp = vec![0; max_sum + 1];

        // Initialize for 1 die
        for i in 1..=6 {
            dp[i] = 1;
        }

        // Iterate for additional dice (from 2nd die up to nth die)
        for k in 2..=n_usize {
            let mut next_dp = vec![0; max_sum + 1];
            // Possible sums for k dice range from k to 6*k
            for s in k..=(6 * k) {
                // To get sum 's' with 'k' dice, the (k-1) dice must have summed to 's-face',
                // where 'face' is the value of the k-th die (1 to 6).
                for face in 1..=6 {
                    let prev_sum = s - face;
                    // Check if prev_sum is a valid sum for (k-1) dice
                    if prev_sum >= (k - 1) && prev_sum <= 6 * (k - 1) {
                        next_dp[s] += dp[prev_sum];
                    }
                }
            }
            dp = next_dp;
        }

        // Calculate total number of outcomes
        let total_outcomes = (6.0_f64).powi(n);

        // Collect probabilities
        let mut result = Vec::new();
        for s in n_usize..=(6 * n_usize) { // Sums range from n to 6n
            result.push(dp[s] as f64 / total_outcomes);
        }

        result
    }
}