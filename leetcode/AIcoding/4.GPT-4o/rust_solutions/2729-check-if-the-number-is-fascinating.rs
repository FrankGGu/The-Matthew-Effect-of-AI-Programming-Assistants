impl Solution {
    pub fn is_fascinating(n: i32) -> bool {
        let mut concatenated = String::new();
        for i in 1..=3 {
            concatenated.push_str(&(n * i).to_string());
        }
        let mut digits = vec![0; 10];
        for c in concatenated.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            if digit == 0 || digits[digit] > 0 {
                return false;
            }
            digits[digit] += 1;
        }
        true
    }
}