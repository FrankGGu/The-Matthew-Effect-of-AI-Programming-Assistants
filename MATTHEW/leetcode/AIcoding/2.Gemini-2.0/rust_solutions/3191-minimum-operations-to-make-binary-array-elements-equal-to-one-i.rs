impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut zeros = 0;
        for &num in &nums {
            if num == 0 {
                zeros += 1;
            }
        }
        zeros
    }
}