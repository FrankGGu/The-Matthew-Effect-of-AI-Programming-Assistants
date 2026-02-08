impl Solution {
    pub fn get_lucky(s: String, k: i32) -> i32 {
        let mut initial_digit_str = String::new();
        for c in s.chars() {
            let pos = (c as u8 - b'a' + 1).to_string();
            initial_digit_str.push_str(&pos);
        }

        let mut current_str = initial_digit_str;
        for i in 0..k {
            let mut sum_of_digits = 0;
            for digit_char in current_str.chars() {
                sum_of_digits += digit_char.to_digit(10).unwrap() as i32;
            }

            if i == k - 1 {
                return sum_of_digits;
            } else {
                current_str = sum_of_digits.to_string();
            }
        }
        unreachable!() 
    }
}