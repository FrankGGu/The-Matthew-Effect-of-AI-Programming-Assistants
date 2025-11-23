impl Solution {
    pub fn find_length_of_lcis(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        let mut max_len = 1;
        let mut current_len = 1;
        for i in 1..nums.len() {
            if nums[i] > nums[i - 1] {
                current_len += 1;
                if current_len > max_len {
                    max_len = current_len;
                }
            } else {
                current_len = 1;
            }
        }
        max_len
    }
}