impl Solution {
    pub fn move_zeroes(nums: &mut Vec<i32>) {
        let mut write_idx = 0;
        for read_idx in 0..nums.len() {
            if nums[read_idx] != 0 {
                nums[write_idx] = nums[read_idx];
                write_idx += 1;
            }
        }
        for i in write_idx..nums.len() {
            nums[i] = 0;
        }
    }
}