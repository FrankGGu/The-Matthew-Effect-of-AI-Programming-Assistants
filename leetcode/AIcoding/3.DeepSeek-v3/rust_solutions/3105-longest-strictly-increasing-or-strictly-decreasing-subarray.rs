impl Solution {
    pub fn longest_monotonic_subarray(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        let mut max_len = 1;
        let mut inc_len = 1;
        let mut dec_len = 1;

        for i in 1..nums.len() {
            if nums[i] > nums[i - 1] {
                inc_len += 1;
                dec_len = 1;
            } else if nums[i] < nums[i - 1] {
                dec_len += 1;
                inc_len = 1;
            } else {
                inc_len = 1;
                dec_len = 1;
            }
            max_len = max_len.max(inc_len.max(dec_len));
        }

        max_len
    }
}