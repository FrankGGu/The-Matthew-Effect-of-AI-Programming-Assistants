impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return n as i32;
        }

        let mut max_len = 1;
        let mut inc_len = 1;
        let mut dec_len = 1;

        for i in 1..n {
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
            max_len = max_len.max(inc_len).max(dec_len);
        }

        max_len
    }
}