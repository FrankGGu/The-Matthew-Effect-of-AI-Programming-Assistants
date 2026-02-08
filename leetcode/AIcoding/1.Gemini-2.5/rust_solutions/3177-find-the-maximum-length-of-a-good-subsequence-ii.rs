use std::cmp::max;

impl Solution {
    pub fn find_maximum_length_of_good_subsequence(nums: Vec<i32>) -> i32 {
        const MAX_VAL: usize = 200000;
        let mut dp: Vec<i32> = vec![0; MAX_VAL + 1];
        let mut is_present: Vec<bool> = vec![false; MAX_VAL + 1];

        for &num in nums.iter() {
            is_present[num as usize] = true;
        }

        let mut overall_max_len = 0;
        if !nums.is_empty() {
            overall_max_len = 1; 
        }

        for i in 1..=MAX_VAL {
            // If 'i' is present in the input array, it can form a subsequence of length 1.
            // Additionally, 'dp[i]' might have been updated by its divisors that were processed earlier.
            // For example, if i=6, dp[6] could have been updated by dp[2] or dp[3].
            // So, dp[i] should be at least 1 if 'i' is present.
            if is_present[i] {
                dp[i] = max(dp[i], 1);
            }

            // If a good subsequence ending with 'i' exists (i.e., dp[i] > 0),
            // then 'i' can be a predecessor for its multiples.
            // For each multiple 'j' of 'i' (where j > i), if 'j' is present in nums,
            // then a good subsequence ending with 'j' can be formed by appending 'j'
            // to a good subsequence ending with 'i'.
            // The length would be 1 + dp[i].
            // We update dp[j] with the maximum such length found so far.
            if dp[i] > 0 {
                for j in (2 * i..=MAX_VAL).step_by(i) {
                    if is_present[j] {
                        dp[j] = max(dp[j], 1 + dp[i]);
                    }
                }
            }

            // Update the overall maximum length found across all numbers.
            overall_max_len = max(overall_max_len, dp[i]);
        }

        overall_max_len
    }
}