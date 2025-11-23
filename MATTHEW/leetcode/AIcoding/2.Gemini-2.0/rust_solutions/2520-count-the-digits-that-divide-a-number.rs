impl Solution {
    pub fn count_digits(num: i32) -> i32 {
        let mut count = 0;
        let s = num.to_string();
        for c in s.chars() {
            let digit = c.to_digit(10).unwrap() as i32;
            if num % digit == 0 {
                count += 1;
            }
        }
        count
    }
}