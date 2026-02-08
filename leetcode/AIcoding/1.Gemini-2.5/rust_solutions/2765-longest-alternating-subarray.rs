impl Solution {
    pub fn longest_alternating_subarray(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        let mut max_len: i32 = 0;
        let mut current_len: i32 = 0;

        for i in 0..n {
            if current_len == 0 {
                if nums[i] % 2 == 0 && nums[i] <= threshold {
                    current_len = 1;
                }
            } else {
                if nums[i] <= threshold && nums[i] % 2 != nums[i - 1] % 2 {
                    current_len += 1;
                } else {
                    current_len = 0;
                    if nums[i] % 2 == 0 && nums[i] <= threshold {
                        current_len = 1;
                    }
                }
            }
            max_len = max_len.max(current_len);
        }

        max_len
    }
}