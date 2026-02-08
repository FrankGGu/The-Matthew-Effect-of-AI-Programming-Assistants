struct Solution;

impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut ans = 0;

        // There are only three possible initial sums that can be the target score.
        // We try each of these as the fixed target score for all operations.

        // 1. Consider nums[0] + nums[1] as the target score
        ans = ans.max(Self::solve_for_target(&nums, nums[0] + nums[1]));

        // 2. Consider nums[0] + nums[n-1] as the target score
        ans = ans.max(Self::solve_for_target(&nums, nums[0] + nums[n - 1]));

        // 3. Consider nums[n-1] + nums[n-2] as the target score
        ans = ans.max(Self::solve_for_target(&nums, nums[n - 1] + nums[n - 2]));

        ans
    }

    // Helper function to calculate maximum operations for a given target_score
    fn solve_for_target(nums: &[i32], target_score: i32) -> i32 {
        let n = nums.len();
        // Memoization table: memo[left][right] stores max operations for the subarray nums[left..right]
        // Initialize with None to indicate that the result for a state has not been computed yet.
        let mut memo: Vec<Vec<Option<i32>>> = vec![vec![None; n]; n];

        // Start the recursive DP from the full array (indices 0 to n-1)
        Self::dp_recursive(0, n - 1, target_score, nums, &mut memo)
    }

    // Recursive DP function with memoization
    // It returns the maximum number of operations possible for the subarray nums[left..right]
    // with the given target_score.
    fn dp_recursive(
        left: usize,
        right: usize,
        target_score: i32,
        nums: &[i32],
        memo: &mut Vec<Vec<Option<i32>>>,
    ) -> i32 {
        // Base case: If the left pointer crosses or meets the right pointer,
        // it means there are 0 or 1 elements left, so no more pairs can be formed.
        if left >= right {
            return 0;
        }

        // Check if the result for this state (left, right) is already in the memoization table
        if let Some(res) = memo[left][right] {
            return res;
        }

        let mut max_ops = 0;

        // Option 1: Try to remove nums[left] and nums[left+1]
        // Condition: Ensure left+1 is a valid index within the current subarray (left + 1 <= right)
        if left + 1 <= right && nums[left] + nums[left + 1] == target_score {
            max_ops = max_ops.max(1 + Self::dp_recursive(left + 2, right, target_score, nums, memo));
        }

        // Option 2: Try to remove nums[left] and nums[right]
        // Condition: left < right is implicitly handled by the base case (left >= right)
        if nums[left] + nums[right] == target_score {
            max_ops = max_ops.max(1 + Self::dp_recursive(left + 1, right - 1, target_score, nums, memo));
        }

        // Option 3: Try to remove nums[right-1] and nums[right]
        // Condition: Ensure right-1 is a valid index and that right-2 won't underflow for the recursive call.
        // This means 'right' must be at least 2 for 'right-2' to be a valid usize index.
        if right >= 2 && nums[right - 1] + nums[right] == target_score {
            max_ops = max_ops.max(1 + Self::dp_recursive(left, right - 2, target_score, nums, memo));
        }

        // Store the computed result in the memoization table before returning
        memo[left][right] = Some(max_ops);
        max_ops
    }
}