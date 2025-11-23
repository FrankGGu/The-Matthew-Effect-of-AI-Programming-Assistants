impl Solution {
    pub fn digit_count(num: String) -> bool {
        let mut count = vec![0; 10];
        for c in num.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            count[digit] += 1;
        }
        for (i, c) in num.chars().enumerate() {
            let digit = c.to_digit(10).unwrap() as usize;
            if count[i] != digit {
                return false;
            }
        }
        true
    }
}