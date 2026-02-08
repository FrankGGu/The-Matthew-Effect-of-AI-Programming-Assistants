impl Solution {
    pub fn second_highest(s: String) -> i32 {
        let mut digits = s.chars()
            .filter(|c| c.is_ascii_digit())
            .map(|c| c.to_digit(10).unwrap())
            .collect::<Vec<_>>();

        digits.sort_unstable();
        digits.dedup();

        if digits.len() < 2 {
            -1
        } else {
            digits[digits.len() - 2] as i32
        }
    }
}