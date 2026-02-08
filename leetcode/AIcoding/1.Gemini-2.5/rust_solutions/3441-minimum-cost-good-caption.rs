use std::collections::HashMap;

impl Solution {
    pub fn minimum_cost(target: String, words: Vec<String>, costs: Vec<i32>) -> i32 {
        // Create a HashMap to store the minimum cost for each unique word.
        // If the same word appears multiple times with different costs, we only care about the minimum.
        // The key is an owned String to allow borrowing `&str` slices for lookups later.
        let mut word_min_costs: HashMap<String, i32> = HashMap::new();
        for i in 0..words.len() {
            let word = &words[i];
            let cost = costs[i];
            word_min_costs
                .entry(word.clone())
                .and_modify(|e| *e = (*e).min(cost))
                .or_insert(cost);
        }

        let n = target.len();
        // dp[i] will store the minimum cost to form the prefix of `target` of length `i`.
        // Initialize with i32::MAX to represent an unachievable state.
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0; // The cost to form an empty prefix is 0.

        // Iterate through all possible end points `i` for the prefix of `target`.
        for i in 1..=n {
            // Iterate through all possible start points `j` for the last word segment.
            // The segment `target[j..i]` represents the last word used to form the prefix of length `i`.
            for j in 0..i {
                // If the prefix up to `j` (i.e., `target[0..j-1]`) is not achievable,
                // we cannot extend from it, so skip this `j`.
                if dp[j] == i32::MAX {
                    continue;
                }

                // Extract the substring `target[j..i]`. This is an `&str` slice.
                let sub_str = &target[j..i];

                // Check if this substring is one of our available words.
                if let Some(&cost) = word_min_costs.get(sub_str) {
                    // If `dp[j]` is not i32::MAX, it means `target[0..j-1]` is formable.
                    // We can potentially form `target[0..i-1]` by appending `sub_str`.
                    // Calculate the total cost for this path: `dp[j] + cost`.
                    // We need to be careful about potential overflow if `dp[j] + cost` exceeds i32::MAX.
                    // However, for typical LeetCode problems of this type, the total cost is expected to fit in i32
                    // if the individual costs and path lengths are within reasonable bounds.
                    // If `dp[j]` is a valid cost (not i32::MAX), and `cost` is also valid,
                    // we assume their sum will not overflow unless explicitly stated otherwise or if the problem implies very large sums.
                    let current_total_cost = dp[j] + cost;
                    // Update `dp[i]` with the minimum cost found so far for this prefix length.
                    dp[i] = dp[i].min(current_total_cost);
                }
            }
        }

        // After filling the DP table, `dp[n]` holds the minimum cost to form the entire `target` string.
        // If `dp[n]` is still i32::MAX, it means the `target` string cannot be formed.
        if dp[n] == i32::MAX {
            -1
        } else {
            dp[n]
        }
    }
}