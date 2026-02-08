impl Solution {
    pub fn array_sign(nums: Vec<i32>) -> i32 {
        let mut sign = 1;
        for &num in &nums {
            if num == 0 {
                return 0;
            } else if num < 0 {
                sign *= -1;
            }
        }
        sign
    }
}