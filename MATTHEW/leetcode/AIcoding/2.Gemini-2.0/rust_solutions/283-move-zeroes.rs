impl Solution {
    pub fn move_zeroes(nums: &mut Vec<i32>) {
        let mut non_zero_index = 0;
        for i in 0..nums.len() {
            if nums[i] != 0 {
                nums.swap(i, non_zero_index);
                non_zero_index += 1;
            }
        }
    }
}