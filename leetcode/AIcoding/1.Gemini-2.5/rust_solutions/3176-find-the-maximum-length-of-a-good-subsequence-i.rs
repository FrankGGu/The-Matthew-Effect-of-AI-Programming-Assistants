impl Solution {
    pub fn find_maximum_length_of_good_subsequence(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        // dp[i] will store the maximum length of a good subsequence ending at nums[i].
        // Each element itself forms a good subsequence of length 1.
        let mut dp = vec![1; n]; 
        let mut max_len = 1;

        // Iterate through each element starting from the second one.
        for i in 1..n {
            // For each nums[i], try to extend a good subsequence ending at a previous element nums[j].
            for j in 0..i {
                // Check if nums[i] can follow nums[j] in a good subsequence.
                if (nums[i] - nums[j]).abs() <= k {
                    // If it can, update dp[i] with the maximum length found so far.
                    // This is 1 (for nums[i] itself) plus the length of the subsequence ending at nums[j].
                    dp[i] = dp[i].max(1 + dp[j]);
                }
            }
            // Update the overall maximum length found across all subsequences.
            max_len = max_len.max(dp[i]);
        }

        max_len
    }
}