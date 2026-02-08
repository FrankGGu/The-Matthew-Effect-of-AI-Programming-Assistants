var maxSumDivisibleByThree = function(nums) {
    // dp[j] will store the maximum sum ending with remainder j when divided by 3.
    // Initialize with 0 for remainder 0, and -Infinity for others as they are not reachable yet.
    let dp = [0, -Infinity, -Infinity];

    for (let num of nums) {
        // Create a temporary array to store the next state of dp.
        // This is crucial to avoid using updated values from the current iteration
        // when calculating other states in the same iteration.
        let next_dp = [...dp]; 

        for (let j = 0; j < 3; j++) {
            // Only consider states that are reachable (not -Infinity).
            if (dp[j] !== -Infinity) {
                let current_sum = dp[j];
                let new_sum = current_sum + num;
                let new_remainder = new_sum % 3;

                // Update the maximum sum for new_remainder.
                next_dp[new_remainder] = Math.max(next_dp[new_remainder], new_sum);
            }
        }
        // Update dp for the next iteration.
        dp = next_dp;
    }

    // The result is the maximum sum with remainder 0.
    return dp[0];
};