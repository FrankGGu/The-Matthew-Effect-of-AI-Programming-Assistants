impl Solution {
    pub fn longest_ones(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut left: usize = 0;
        let mut zero_count: i32 = 0;
        let mut max_len: i32 = 0;

        for right in 0..n {
            if nums[right] == 0 {
                zero_count += 1;
            }

            while zero_count > k {
                if nums[left] == 0 {
                    zero_count -= 1;
                }
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}