impl Solution {
    pub fn longest_alternating_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return n as i32;
        }

        let mut max_len = 1;
        let mut curr_len = 1;

        for i in 1..n {
            if (nums[i] > nums[i - 1] && (i == 1 || nums[i - 1] < nums[i - 2])) ||
               (nums[i] < nums[i - 1] && (i == 1 || nums[i - 1] > nums[i - 2])) {
                curr_len += 1;
            } else {
                max_len = max_len.max(curr_len);
                curr_len = 1;
            }
        }

        max_len.max(curr_len) as i32
    }
}