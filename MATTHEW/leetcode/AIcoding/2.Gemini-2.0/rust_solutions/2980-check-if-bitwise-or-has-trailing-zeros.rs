impl Solution {
    pub fn has_trailing_zeros(nums: Vec<i32>) -> bool {
        let mut count = 0;
        for &num in &nums {
            if num % 2 == 0 {
                count += 1;
            }
            if count >= 2 {
                return true;
            }
        }
        false
    }
}