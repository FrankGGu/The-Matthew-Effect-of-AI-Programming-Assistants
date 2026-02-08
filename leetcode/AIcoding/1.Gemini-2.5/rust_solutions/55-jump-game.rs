impl Solution {
    pub fn can_jump(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 1 {
            return true;
        }

        let mut max_reach = 0; // Represents the farthest index reachable so far

        for i in 0..n {
            // If the current index `i` is beyond the `max_reach`,
            // it means we cannot reach this index, and thus cannot reach the end.
            if i > max_reach {
                return false;
            }

            // Update `max_reach` with the maximum of its current value
            // and the farthest index reachable from the current position `i`.
            max_reach = max_reach.max(i as i32 + nums[i]);

            // If `max_reach` is greater than or equal to the last index,
            // we can reach the end.
            if max_reach >= (n - 1) as i32 {
                return true;
            }
        }

        // This line should technically not be reached if the loop condition and early exit are correct,
        // as the loop covers all possibilities up to n-1.
        // If the loop finishes without returning true, it means max_reach never reached n-1.
        false
    }
}