impl Solution {
    pub fn alternating_digit_sum(n: i32) -> i32 {
        let s = n.to_string();
        let mut sum = 0;
        for (i, c) in s.chars().enumerate() {
            let digit = c.to_digit(10).unwrap() as i32;
            if i % 2 == 0 {
                sum += digit;
            } else {
                sum -= digit;
            }
        }
        sum
    }
}