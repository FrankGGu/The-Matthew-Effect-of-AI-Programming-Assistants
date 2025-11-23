impl Solution {
    pub fn is_fascinating(n: i32) -> bool {
        let concatenated = format!("{}{}{}", n, 2 * n, 3 * n);
        if concatenated.len() != 9 {
            return false;
        }
        let mut digits = [false; 10];
        for c in concatenated.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            if digit == 0 || digits[digit] {
                return false;
            }
            digits[digit] = true;
        }
        true
    }
}