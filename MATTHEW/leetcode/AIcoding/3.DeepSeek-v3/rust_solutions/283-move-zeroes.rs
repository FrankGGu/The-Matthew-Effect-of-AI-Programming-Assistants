impl Solution {
    pub fn move_zeroes(nums: &mut Vec<i32>) {
        let mut non_zero = 0;
        for i in 0..nums.len() {
            if nums[i] != 0 {
                nums[non_zero] = nums[i];
                non_zero += 1;
            }
        }
        for i in non_zero..nums.len() {
            nums[i] = 0;
        }
    }
}