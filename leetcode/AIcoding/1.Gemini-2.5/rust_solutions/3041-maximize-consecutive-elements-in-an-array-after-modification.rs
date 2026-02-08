impl Solution {
    pub fn maximize_consecutive(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut nums = nums;
        nums.sort_unstable();
        nums.dedup();

        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut max_len = 0;
        let mut left = 0;

        for right in 0..n {
            // The condition for a valid window [left, right] is that
            // nums[right] - nums[left] <= (right - left) + 1.
            // This means the span of values (nums[right] - nums[left])
            // is at most 1 greater than the number of elements in the window (right - left).
            // If it's equal to (right - left), all elements are already consecutive.
            // If it's equal to (right - left) + 1, there's exactly one gap of size 1,
            // which can be filled by the single allowed increment operation.
            while nums[right] - nums[left] > (right - left) as i32 + 1 {
                left += 1;
            }
            // The current window [left, right] is valid.
            // The length of the consecutive sequence we can form is (right - left + 1).
            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}