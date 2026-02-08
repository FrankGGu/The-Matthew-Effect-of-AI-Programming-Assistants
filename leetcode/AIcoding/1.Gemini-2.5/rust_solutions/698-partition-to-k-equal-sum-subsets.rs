use std::collections::HashMap;

impl Solution {
    pub fn can_partition_k_subsets(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        if k <= 0 || k > n as i32 {
            return false;
        }

        let total_sum: i32 = nums.iter().sum();
        if total_sum % k != 0 {
            return false;
        }

        let target_sum = total_sum / k;

        // Sort nums in descending order. This helps in pruning branches faster.
        // Larger numbers are tried first, which can lead to earlier failures if they don't fit.
        let mut nums = nums;
        nums.sort_unstable_by(|a, b| b.cmp(a));

        // If any number is greater than target_sum, it's impossible.
        // This check is more robust after sorting, as nums[0] will be the largest.
        if nums[0] > target_sum {
            return false;
        }

        // Memoization table: (visited_mask, k_remaining) -> bool
        // `visited_mask`: a bitmask representing which numbers have been used.
        // `k_remaining`: the number of subsets we still need to form.
        let mut memo: HashMap<(i32, i32), bool> = HashMap::new();

        Self::backtrack(
            &nums,
            k, // k_remaining: initially the total k
            target_sum,
            0, // current_subset_sum: sum for the subset currently being built
            0, // start_idx: index to start searching from for the current subset (optimization)
            0, // visited_mask: initially no numbers are used
            &mut memo,
        )
    }

    // `k_remaining`: How many subsets we still need to form.
    // `current_subset_sum`: The sum of the subset we are currently building.
    // `start_idx`: The index in `nums` from which to start considering numbers for the current subset.
    //              This avoids redundant permutations (e.g., [1,2] then [2,1] for a subset)
    //              and ensures each number is tried once for the current subset.
    // `visited_mask`: Bitmask of numbers already used across all subsets.
    // `memo`: Memoization table.
    fn backtrack(
        nums: &[i32],
        k_remaining: i32,
        target_sum: i32,
        current_subset_sum: i32,
        start_idx: usize,
        visited_mask: i32,
        memo: &mut HashMap<(i32, i32), bool>,
    ) -> bool {
        // Base case 1: All k subsets have been formed successfully.
        if k_remaining == 0 {
            return true;
        }

        // Base case 2: The current subset is complete.
        if current_subset_sum == target_sum {
            // One subset formed. Now try to form `k_remaining - 1` more subsets.
            // Start building a new subset (`current_subset_sum = 0`) from the beginning (`start_idx = 0`).
            // The `visited_mask` carries over.
            return Self::backtrack(
                nums,
                k_remaining - 1, // One less subset to form
                target_sum,
                0, // Start a new subset with sum 0
                0, // Start searching from index 0 for the new subset
                visited_mask,
                memo,
            );
        }

        // Memoization check:
        // We only memoize states where we are starting to build a new subset (`current_subset_sum == 0`).
        // If `current_subset_sum > 0`, we are in an intermediate step of building a subset,
        // and that specific intermediate state is not part of the memoization key `(visited_mask, k_remaining)`.
        if current_subset_sum == 0 {
            if let Some(&res) = memo.get(&(visited_mask, k_remaining)) {
                return res;
            }
        }

        // Try to add numbers to the current subset.
        for i in start_idx..nums.len() {
            // Check if `nums[i]` has not been visited (`((visited_mask >> i) & 1) == 0`)
            // AND adding it doesn't exceed `target_sum`.
            if ((visited_mask >> i) & 1) == 0 && current_subset_sum + nums[i] <= target_sum {
                // Mark `nums[i]` as visited.
                let new_visited_mask = visited_mask | (1 << i);

                // Recursively call `backtrack` to try adding `nums[i]` to the current subset.
                // `i + 1` is passed as `start_idx` to ensure numbers are picked in increasing order of index
                // for the *current* subset, avoiding redundant permutations.
                if Self::backtrack(
                    nums,
                    k_remaining,
                    target_sum,
                    current_subset_sum + nums[i],
                    i + 1, // Next search starts from the next index
                    new_visited_mask,
                    memo,
                ) {
                    // If a solution is found, memoize and return true.
                    // This memoization happens only if `current_subset_sum == 0` (starting a new subset).
                    if current_subset_sum == 0 {
                        memo.insert((visited_mask, k_remaining), true);
                    }
                    return true;
                }

                // Optimization for duplicate numbers:
                // If the current number `nums[i]` didn't lead to a solution, and there are identical
                // numbers immediately following it, skip them. This avoids redundant checks
                // for permutations that would result in the same subset sum and mask state.
                while i + 1 < nums.len() && nums[i + 1] == nums[i] {
                    // This `while` loop needs to be careful with `i` and `start_idx`.
                    // The `for` loop already increments `i`. This `while` loop should be `i += 1` instead of `i++` for `for` loop.
                    // For `for i in start_idx..nums.len()`, `i` is managed by the loop.
                    // If we want to skip, we need to manually advance `i`.
                    // However, `start_idx` and `visited_mask` already handle uniqueness effectively.
                    // The sorting helps with pruning. Explicitly skipping identical values here
                    // is a more complex optimization that might interact with `start_idx` and `visited_mask` in subtle ways.
                    // For `N=16`, the current approach is usually sufficient.
                }
            }
        }

        // If no number could be added to complete the current subset or find a solution.
        // Memoize failure, but only if `current_subset_sum == 0` (starting a new subset).
        if current_subset_sum == 0 {
            memo.insert((visited_mask, k_remaining), false);
        }
        false
    }
}