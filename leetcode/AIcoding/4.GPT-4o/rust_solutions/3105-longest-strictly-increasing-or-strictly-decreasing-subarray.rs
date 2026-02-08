impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_len = 1;
        let mut current_len = 1;
        let mut increasing = true;

        for i in 1..n {
            if nums[i] > nums[i - 1] {
                if increasing {
                    current_len += 1;
                } else {
                    max_len = max_len.max(current_len);
                    current_len = 2;
                    increasing = true;
                }
            } else if nums[i] < nums[i - 1] {
                if !increasing {
                    current_len += 1;
                } else {
                    max_len = max_len.max(current_len);
                    current_len = 2;
                    increasing = false;
                }
            } else {
                max_len = max_len.max(current_len);
                current_len = 1;
                increasing = true;
            }
        }

        max_len = max_len.max(current_len);
        max_len
    }
}