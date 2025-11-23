use std::cmp::min;

impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_long = k as i64;

        // dp[i] will store the minimum cost to divide the prefix nums[0...i-1]
        // dp[0] = 0, meaning the cost to divide an empty prefix is 0.
        // All other dp[i] are initialized to a very large value (infinity).
        let mut dp = vec![i64::MAX; n + 1];
        dp[0] = 0;

        // Iterate through all possible end points of the current prefix (exclusive)
        // i represents the current length of the prefix nums[0...i-1]
        for i in 1..=n {
            // For each prefix nums[0...i-1], we consider all possible last subarrays
            // ending at index i-1 and starting at index j.
            // The last subarray is nums[j...i-1].

            // Use a frequency array to efficiently calculate the trimmed mean for subarrays.
            // Since 0 <= nums[x] < nums.length, a vector of size n is sufficient for counts.
            let mut counts = vec![0; n];
            let mut current_trimmed_mean = 0;

            // Iterate backwards from i-1 to 0 to form subarrays nums[j...i-1]
            // This allows us to extend the subarray to the left and update trimmed_mean incrementally.
            for j in (0..i).rev() {
                let val = nums[j] as usize;

                // Update counts for the current element nums[j]
                let old_count = counts[val];
                counts[val] += 1;

                // Update current_trimmed_mean based on the definition:
                // trimmed_mean is the sum of (frequency - 1) for each element that appears at least twice.
                //
                // Logic for updating current_trimmed_mean:
                // - If old_count was 0 (element was not present): new_count is 1. No element appears twice yet.
                //   trimmed_mean does not change.
                // - If old_count was 1 (element was present once): new_count is 2. This element now appears twice.
                //   Its contribution changes from (1-1)=0 to (2-1)=1. So, trimmed_mean increases by 1.
                // - If old_count >= 2 (element was already present at least twice): new_count is old_count + 1.
                //   Its contribution changes from (old_count-1) to (new_count-1) = (old_count+1-1) = old_count.
                //   The change is old_count - (old_count-1) = 1. So, trimmed_mean increases by 1.
                // In summary, if the element was already present at least once (old_count >= 1),
                // the current_trimmed_mean increases by 1.
                if old_count >= 1 {
                    current_trimmed_mean += 1;
                }

                // Calculate the total cost for this division:
                // dp[j] (cost to divide prefix nums[0...j-1])
                // + current_trimmed_mean (cost of the last subarray nums[j...i-1])
                // + k_long (cost for one division)
                // Update dp[i] with the minimum cost found so far.
                if dp[j] != i64::MAX { // Ensure dp[j] is a reachable state
                    dp[i] = min(dp[i], dp[j] + current_trimmed_mean + k_long);
                }
            }
        }

        // The minimum cost to divide the entire array nums[0...n-1] is dp[n].
        // Cast the result back to i32 as required by the function signature.
        dp[n] as i32
    }
}