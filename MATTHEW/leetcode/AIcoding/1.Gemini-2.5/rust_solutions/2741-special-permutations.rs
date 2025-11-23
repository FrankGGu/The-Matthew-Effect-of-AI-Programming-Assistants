impl Solution {
    pub fn special_permutations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        // dp[mask][last_idx] stores the number of special permutations
        // using elements represented by 'mask', where the permutation ends with nums[last_idx].
        let mut dp = vec![vec![0; n]; 1 << n];

        // Base cases: permutations of length 1
        // Each single element forms a special permutation of length 1.
        for i in 0..n {
            dp[1 << i][i] = 1;
        }

        // Iterate through all possible masks (subsets of elements)
        // A mask represents the set of elements used in a permutation.
        for mask in 1..(1 << n) {
            // Iterate through each element 'i' that could be the last element
            // in the permutation represented by the current 'mask'.
            for i in 0..n {
                // If the i-th bit is not set in the mask, it means nums[i] is not part of this subset,
                // so we skip this state.
                if (mask & (1 << i)) == 0 {
                    continue;
                }

                // If the mask only has one bit set, it means it's a permutation of length 1.
                // These are our base cases, already initialized. We skip further processing for them.
                if mask.count_ones() == 1 {
                    continue;
                }

                // Iterate through each element 'j' that could be the second to last element
                // in the permutation.
                for j in 0..n {
                    // If j is the same as i, or the j-th element is not in the mask
                    // (meaning it wasn't part of the previous permutation state), skip.
                    if i == j || (mask & (1 << j)) == 0 {
                        continue;
                    }

                    // Calculate the mask for the previous state: current mask without nums[i].
                    let prev_mask = mask ^ (1 << i);

                    // Check the divisibility condition: nums[i] % nums[j] == 0 or nums[j] % nums[i] == 0.
                    if nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0 {
                        // If the condition holds, we can extend permutations ending with nums[j]
                        // (represented by dp[prev_mask][j]) by adding nums[i].
                        dp[mask][i] += dp[prev_mask][j];
                    }
                }
            }
        }

        // After filling the DP table, sum up all permutations that use all 'n' elements.
        // The full_mask has all bits set, representing all elements being used.
        let full_mask = (1 << n) - 1;
        let mut total_permutations = 0;
        for i in 0..n {
            total_permutations += dp[full_mask][i];
        }

        total_permutations
    }
}