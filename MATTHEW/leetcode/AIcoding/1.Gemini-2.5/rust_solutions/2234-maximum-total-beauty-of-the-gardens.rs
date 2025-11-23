use std::cmp::max;

impl Solution {
    pub fn maximum_total_beauty(flowers: Vec<i64>, new_flowers: i64, target: i64, full_beauty: i64, partial_beauty: i64) -> i64 {
        let n = flowers.len();
        let mut flowers = flowers;
        flowers.sort_unstable();

        // prefix_sum[i] stores sum of flowers[0]...flowers[i-1]
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + flowers[i];
        }

        let mut max_total_beauty = 0;
        let mut current_full_cost = 0; // Cost to make `k` gardens full (from the right end of sorted `flowers`)

        // Iterate `k` from 0 to n, where `k` is the number of full gardens.
        // These `k` gardens are `flowers[n-k], ..., flowers[n-1]`.
        // The loop calculates beauty for `k` full gardens and `n-k` partial gardens.
        for k in 0..=n {
            // If current_full_cost exceeds new_flowers, we cannot afford to make `k` gardens full.
            // Since `current_full_cost` is non-decreasing with `k`, we can break.
            if current_full_cost > new_flowers {
                break;
            }

            let remaining_flowers_for_partial = new_flowers - current_full_cost;
            let mut current_beauty = k as i64 * full_beauty;

            // Calculate partial beauty for the remaining `n-k` gardens: flowers[0...n-k-1]
            let num_partial_gardens = n - k;
            if num_partial_gardens > 0 {
                // Binary search for the maximum `min_flowers_val` for partial gardens.
                // This `min_flowers_val` must be < target.
                let mut low = 0;
                let mut high = target - 1; // Max possible flowers for a partial garden
                let mut max_partial_flowers_val = 0;

                while low <= high {
                    let mid = low + (high - low) / 2;

                    // Find count of gardens in `flowers[0...num_partial_gardens-1]` that are less than `mid`.
                    // `idx_upper_bound` is the count of such gardens.
                    // Rust's `partition_point` is suitable here.
                    let idx_upper_bound = flowers[0..num_partial_gardens].partition_point(|&f| f < mid);

                    // Cost to raise `flowers[0...idx_upper_bound-1]` up to `mid` flowers.
                    let cost_to_raise_to_mid = idx_upper_bound as i64 * mid - prefix_sum[idx_upper_bound];

                    if cost_to_raise_to_mid <= remaining_flowers_for_partial {
                        max_partial_flowers_val = mid;
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                current_beauty += max_partial_flowers_val * partial_beauty;
            }

            max_total_beauty = max(max_total_beauty, current_beauty);

            // Update `current_full_cost` for the next iteration (k+1 full gardens).
            // The `k+1`-th full garden is `flowers[n - 1 - k]`.
            if k < n {
                let garden_to_make_full = flowers[n - 1 - k];
                if garden_to_make_full < target {
                    current_full_cost += target - garden_to_make_full;
                }
            }
        }

        max_total_beauty
    }
}