impl Solution {
    pub fn clear_digits(num: String) -> String {
        num.chars().filter(|c| !c.is_digit(10)).collect()
    }
}