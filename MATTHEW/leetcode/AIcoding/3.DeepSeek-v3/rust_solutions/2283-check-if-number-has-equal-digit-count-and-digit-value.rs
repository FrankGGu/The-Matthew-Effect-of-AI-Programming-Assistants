impl Solution {
    pub fn digit_count(num: String) -> bool {
        let mut counts = [0; 10];
        for c in num.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            counts[digit] += 1;
        }
        for (i, c) in num.chars().enumerate() {
            let expected = c.to_digit(10).unwrap() as usize;
            if counts[i] != expected {
                return false;
            }
        }
        true
    }
}