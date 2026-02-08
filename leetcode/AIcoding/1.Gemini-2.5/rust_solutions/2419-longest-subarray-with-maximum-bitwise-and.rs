impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let max_val = *nums.iter().max().unwrap_or(&0);
        let mut max_len = 0;
        let mut current_len = 0;

        for &num in nums.iter() {
            if num == max_val {
                current_len += 1;
            } else {
                current_len = 0;
            }
            if current_len > max_len {
                max_len = current_len;
            }
        }
        max_len
    }
}