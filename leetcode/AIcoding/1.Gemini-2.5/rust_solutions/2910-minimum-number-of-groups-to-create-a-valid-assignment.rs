use std::collections::HashMap;
use std::cmp;

impl Solution {
    pub fn min_groups_for_valid_assignment(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for num in nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut min_count = i32::MAX;
        for &count in counts.values() {
            min_count = cmp::min(min_count, count);
        }

        let mut min_total_groups = i32::MAX;

        // The minimum group size 'k' must be less than or equal to the minimum frequency
        // of any item type (min_count).
        // If k > min_count, then for the item type with 'min_count' items,
        // we would need at least one group of size 'k'. However, since min_count < k,
        // it's impossible to form a group of size 'k' or 'k+1' from 'min_count' items.
        // More formally, if k > min_count, then for count = min_count:
        // num_groups_for_c = (min_count + k) / (k + 1) will be 1 (since k <= min_count + k < 2*(k+1) if min_count < k+2).
        // The condition for validity is num_groups_for_c * k <= count, which becomes 1 * k <= min_count, or k <= min_count.
        // This contradicts our assumption k > min_count. Thus, k must be <= min_count.
        for k in 1..=min_count {
            let mut current_total_groups = 0;
            let mut k_is_valid = true;

            for &count in counts.values() {
                // Calculate the minimum number of groups needed for 'count' items
                // given group sizes k or k+1. This is ceil(count / (k + 1)).
                // Using integer division: (count + k) / (k + 1)
                let num_groups_for_c = (count + k) / (k + 1);

                // Check if it's actually possible to form 'count' items using 'num_groups_for_c' groups
                // where each group has size k or k+1.
                // The minimum total items for 'num_groups_for_c' groups, if all groups are of size 'k',
                // would be num_groups_for_c * k.
                // If 'count' is less than this minimum possible sum, then it's impossible to form
                // 'num_groups_for_c' groups each of size at least 'k' to sum up to 'count'.
                if num_groups_for_c * k > count {
                    k_is_valid = false;
                    break;
                }
                current_total_groups += num_groups_for_c;
            }

            if k_is_valid {
                min_total_groups = cmp::min(min_total_groups, current_total_groups);
            }
        }

        min_total_groups
    }
}