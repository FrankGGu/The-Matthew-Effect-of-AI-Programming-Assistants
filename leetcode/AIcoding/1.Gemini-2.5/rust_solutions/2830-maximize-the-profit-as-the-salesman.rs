use std::cmp::max;

impl Solution {
    pub fn maximize_the_profit(n: i32, mut offers: Vec<Vec<i32>>) -> i32 {
        // Sort offers by their end times. If end times are equal, sort by start times.
        // This helps in the dynamic programming approach to efficiently find non-overlapping previous offers.
        offers.sort_unstable_by(|a, b| {
            if a[1] != b[1] {
                a[1].cmp(&b[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let k = offers.len();
        // dp[i] will store the maximum profit considering the first i offers (0-indexed offers[0] to offers[i-1]).
        // dp[0] = 0, meaning no offers considered, no profit.
        // dp[i+1] will store the max profit considering offers up to index i.
        let mut dp = vec![0; k + 1];

        for i in 0..k {
            let current_offer = &offers[i];
            let start = current_offer[0];
            let profit = current_offer[2];

            // Option 1: Do not take the current offer.
            // The maximum profit remains the same as considering offers up to the previous one.
            let profit_without_current = dp[i];

            // Option 2: Take the current offer.
            // If we take the current offer, we cannot take any offer that overlaps with it.
            // We need to find the latest offer `j` (where `j < i`) such that `offers[j].end < start`.
            // The profit from taking the current offer would be `profit` + (max profit up to offer `j`).

            // Use binary search (partition_point) to find the insertion point for `start`.
            // `offers[0..i]` contains offers that end before or at `offers[i-1].end`.
            // We are looking for the largest index `prev_idx` such that `offers[prev_idx-1].end < start`.
            // `partition_point` returns the index of the first element for which the predicate is false.
            // So, `offers[0..prev_idx-1]` all satisfy `offer[1] < start`.
            // `offers[prev_idx]` (if it exists) has `offer[1] >= start`.
            // Thus, `dp[prev_idx]` holds the maximum profit considering offers that end strictly before `start`.
            let prev_idx = offers[0..i].partition_point(|offer| offer[1] < start);

            let profit_with_current = profit + dp[prev_idx];

            // The maximum profit up to the current offer (index i) is the maximum of these two options.
            dp[i + 1] = max(profit_without_current, profit_with_current);
        }

        // The last element of dp array contains the maximum profit considering all offers.
        dp[k]
    }
}