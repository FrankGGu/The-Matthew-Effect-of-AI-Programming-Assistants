struct Solution;

impl Solution {
    pub fn is_sum_equal(left: String, right: String) -> bool {
        let sum = |s: &str| s.chars().map(|c| c as u8 - b'0').sum::<u8>();
        let left_sum = sum(&left);
        let right_sum = sum(&right);
        left_sum == right_sum
    }
}