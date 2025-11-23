impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        // dp[i] stores the minimum cost to split the prefix nums[0...i-1]
        // Use i64 for dp values to prevent potential overflow, as costs can be large.
        let mut dp = vec![i64::MAX; n + 1];
        dp[0] = 0; // Base case: cost to split an empty array is 0

        // Iterate through all possible end points of the array (i)
        for i in 1..=n {
            let mut current_trim_cost = 0;
            // Frequency array to count elements in the current subarray nums[j...i-1]
            // Max value of nums[i] is 1000, so size 1001 is sufficient for indices 0-1000.
            let mut freq = vec![0; 1001]; 

            // Iterate backwards from i-1 to 0 to consider all possible start points (j)
            // for the last subarray nums[j...i-1]
            for j in (0..i).rev() {
                let num = nums[j];

                // Update current_trim_cost based on the frequency of 'num'
                // If 'num' was seen once, it now appears twice, increasing trim_cost by 1.
                // If 'num' was seen more than once, it now appears one more time,
                // also increasing trim_cost by 1.
                if freq[num as usize] == 1 {
                    current_trim_cost += 1;
                } else if freq[num as usize] > 1 {
                    current_trim_cost += 1;
                }
                freq[num as usize] += 1; // Increment frequency for the current number

                // Calculate dp[i] using dp[j] and the cost of the current subarray nums[j..i-1]
                // The cost of the subarray is k + trim_cost.
                // Ensure dp[j] is a reachable state (not i64::MAX)
                if dp[j] != i64::MAX {
                    dp[i] = dp[i].min(dp[j] + k as i64 + current_trim_cost as i64);
                }
            }
        }

        // The result is the minimum cost to split the entire array nums[0...n-1]
        // Cast to i32 as per the function signature. This assumes the final result fits in i32.
        dp[n] as i32
    }
}