impl Solution {
    pub fn semi_ordered_permutation(nums: Vec<i32>) -> i32 {
        let mut first_index = 0;
        let mut last_index = 0;
        let n = nums.len();

        for i in 0..n {
            if nums[i] == 1 {
                first_index = i;
            }
            if nums[i] == n as i32 {
                last_index = i;
            }
        }

        if first_index > last_index {
            first_index + (n - 1 - last_index) - 1
        } else {
            first_index + (n - 1 - last_index)
        }
    }
}