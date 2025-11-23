impl Solution {
    pub fn maximum_moves(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        // dp[i] represents the maximum number of moves to reach index i,
        // starting from index 0.
        // A value of 0 means either index i is the starting point (i=0)
        // or it's not reachable as part of a valid sequence of moves
        // starting from index 0.
        let mut dp = vec![0; n];

        // dp[0] is initialized to 0, as it takes 0 moves to be at the starting position.

        for i in 1..n {
            // Case 1: The current index i is the first move from index 0.
            // If nums[i] is greater than nums[0], then we can make 1 move to reach i.
            if nums[i] > nums[0] {
                dp[i] = 1;
            }

            // Case 2: The current index i extends a sequence from a previous index j.
            // j must be reachable from 0, meaning dp[j] must be greater than 0.
            // We iterate j from 1 to i-1 because dp[0] is 0 and cannot be part of an
            // extension (it's the starting point, not an intermediate step with moves).
            for j in 1..i {
                if dp[j] > 0 && nums[i] > nums[j] {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        // The maximum number of moves is the maximum value in the dp array.
        // If no moves are possible, all dp[i] for i > 0 will be 0, and the max will be 0.
        *dp.iter().max().unwrap_or(&0)
    }
}