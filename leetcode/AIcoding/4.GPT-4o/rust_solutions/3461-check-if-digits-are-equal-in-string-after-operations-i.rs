impl Solution {
    pub fn are_numbers_equal(num1: String, num2: String) -> bool {
        num1.chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>() ==
        num2.chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>()
    }
}