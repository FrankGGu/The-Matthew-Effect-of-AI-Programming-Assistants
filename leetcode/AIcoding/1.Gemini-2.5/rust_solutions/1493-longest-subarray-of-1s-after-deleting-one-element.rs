impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = 0;
        let mut zero_count = 0;
        let mut max_len_window = 0;

        for right in 0..n {
            if nums[right] == 0 {
                zero_count += 1;
            }

            while zero_count > 1 {
                if nums[left] == 0 {
                    zero_count -= 1;
                }
                left += 1;
            }

            // The current window [left, right] contains at most one zero.
            // Its length is (right - left + 1).
            max_len_window = max_len_window.max(right - left + 1);
        }

        // The problem requires deleting exactly one element.
        // `max_len_window` stores the length of the longest subarray with at most one zero.
        // Case 1: The longest window contains one zero (e.g., [1,1,0,1,1]).
        //         Length is `max_len_window`. Deleting the zero leaves `max_len_window - 1` ones.
        // Case 2: The longest window contains no zeros (e.g., [1,1,1,1]).
        //         Length is `max_len_window`. We must delete one '1', leaving `max_len_window - 1` ones.
        // In both cases, the result is `max_len_window - 1`.
        // This also handles edge cases like `[0,0,0]` (max_len_window=1, result=0)
        // and `[1]` (max_len_window=1, result=0).
        (max_len_window - 1) as i32
    }
}