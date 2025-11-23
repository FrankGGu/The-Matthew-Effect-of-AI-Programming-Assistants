impl Solution {
    pub fn is_fascinating(n: i32) -> bool {
        let s = format!("{}{}{}", n, n * 2, n * 3);
        if s.len() != 9 {
            return false;
        }
        let mut count = [0; 10];
        for c in s.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            if digit == 0 {
                return false;
            }
            count[digit] += 1;
        }
        for i in 1..=9 {
            if count[i] != 1 {
                return false;
            }
        }
        true
    }
}