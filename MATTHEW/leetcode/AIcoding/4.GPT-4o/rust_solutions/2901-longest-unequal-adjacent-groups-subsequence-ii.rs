impl Solution {
    pub fn longest_unequal_adjacent_groups(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 { return n as i32; }

        let mut max_length = 1;
        let mut current_length = 1;

        for i in 1..n {
            if nums[i] != nums[i - 1] {
                current_length += 1;
            } else {
                max_length = max_length.max(current_length);
                current_length = 1;
            }
        }

        max_length = max_length.max(current_length);
        max_length
    }
}