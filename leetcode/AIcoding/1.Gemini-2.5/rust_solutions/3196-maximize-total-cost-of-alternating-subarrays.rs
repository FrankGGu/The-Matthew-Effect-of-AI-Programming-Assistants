impl Solution {
    pub fn maximize_total_cost(nums: Vec<i32>) -> i64 {
        let n = nums.len();

        // dp_pos represents the maximum total cost ending at the current index,
        // where the last element of its subarray has a positive sign.
        // dp_neg represents the maximum total cost ending at the current index,
        // where the last element of its subarray has a negative sign.

        // Initialize for the first element (index 0).
        // nums[0] can only start a new subarray, so its sign must be positive.
        let mut dp_pos = nums[0] as i64;

        // It's impossible for a single-element subarray to end with a negative sign.
        // We use a very small number (negative infinity) to indicate this state is unreachable.
        // i64::MIN / 2 is chosen to prevent potential overflow issues if we were to add/subtract
        // from i64::MIN directly.
        let mut dp_neg = i64::MIN / 2; 

        // Iterate from the second element to the end of the array.
        for i in 1..n {
            let num = nums[i] as i64;

            // Calculate the next dp_pos and dp_neg values based on the current ones (from i-1).

            // To calculate next_dp_pos (max cost ending with +num):
            // There are two ways to achieve this:
            // 1. 'num' starts a new alternating subarray:
            //    The total cost would be (max total cost up to i-1) + num.
            //    The max total cost up to i-1 is max(dp_pos, dp_neg).
            //    So, this path gives: max(dp_pos, dp_neg) + num.
            // 2. 'num' extends an existing subarray that ended at (i-1) with -nums[i-1]:
            //    The total cost would be dp_neg + num.
            // Combining these, next_dp_pos = max(max(dp_pos, dp_neg) + num, dp_neg + num).
            // Since max(dp_pos, dp_neg) is always greater than or equal to dp_neg,
            // this simplifies to: max(dp_pos, dp_neg) + num.
            let next_dp_pos = dp_pos.max(dp_neg) + num;

            // To calculate next_dp_neg (max cost ending with -num):
            // 'num' must extend an existing subarray that ended at (i-1) with +nums[i-1].
            // The total cost would be dp_pos - num.
            // 'num' cannot start a new subarray with a negative sign.
            let next_dp_neg = dp_pos - num;

            // Update dp_pos and dp_neg for the next iteration.
            dp_pos = next_dp_pos;
            dp_neg = next_dp_neg;
        }

        // The final answer is the maximum of the two possibilities for the last element:
        // ending with a positive sign or ending with a negative sign.
        dp_pos.max(dp_neg)
    }
}