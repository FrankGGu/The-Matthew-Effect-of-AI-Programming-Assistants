use std::collections::HashMap;

impl Solution {
    pub fn minimum_total_cost(nums1: Vec<i32>, nums2: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = nums1.len();
        let mut total_current_cost: i64 = 0;
        let mut bad_indices_count = 0;
        let mut bad_values_freq: HashMap<i32, i32> = HashMap::new();

        for i in 0..n {
            if nums1[i] == nums2[i] {
                total_current_cost += cost[i] as i64;
                bad_indices_count += 1;
                *bad_values_freq.entry(nums1[i]).or_insert(0) += 1;
            }
        }

        if bad_indices_count == 0 {
            return 0;
        }

        let mut max_freq_val = -1;
        let mut max_freq_count = 0;

        for (&val, &count) in bad_values_freq.iter() {
            if count > max_freq_count {
                max_freq_count = count;
                max_freq_val = val;
            }
        }

        if max_freq_count * 2 <= bad_indices_count {
            // No single value dominates. All conflicts can be resolved by swapping elements
            // currently at bad_indices. Each bad_index i contributes cost[i] to the total.
            return total_current_cost;
        } else {
            // A value `max_freq_val` dominates.
            // `max_freq_count` occurrences of `max_freq_val` are at bad_indices.
            // `bad_indices_count - max_freq_count` are other bad_indices.
            // The number of `max_freq_val` instances that cannot be resolved by swapping with
            // other bad_indices is `max_freq_count - (bad_indices_count - max_freq_count)`.
            // These `excess_count` instances must be resolved by swapping with "good" indices.
            let excess_count = max_freq_count * 2 - bad_indices_count;

            let mut eligible_good_costs: Vec<i32> = Vec::new();

            for i in 0..n {
                if nums1[i] != nums2[i] { // This is a "good" index
                    // If we swap nums1[i] (from a bad spot where value was max_freq_val)
                    // with original nums1[i] (from this good spot j):
                    // 1. The bad spot now has original nums1[i]. This must not be max_freq_val.
                    //    So, original nums1[i] != max_freq_val.
                    // 2. This good spot now has max_freq_val. This must not be nums2[i].
                    //    So, max_freq_val != nums2[i].
                    if nums1[i] != max_freq_val && max_freq_val != nums2[i] {
                        eligible_good_costs.push(cost[i]);
                    }
                }
            }

            if eligible_good_costs.len() < excess_count as usize {
                return -1; // Not enough eligible good indices to resolve the excess
            }

            eligible_good_costs.sort_unstable(); // Sort to pick the cheapest ones

            // Add the costs of the cheapest `excess_count` good indices to the total.
            // The cost[i] for the bad indices are already included in total_current_cost.
            for k in 0..excess_count as usize {
                total_current_cost += eligible_good_costs[k] as i64;
            }

            return total_current_cost;
        }
    }
}