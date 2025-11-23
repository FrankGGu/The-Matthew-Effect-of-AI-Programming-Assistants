struct Solution;

impl Solution {
    pub fn smallest_palindromic_rearrangement(s: String) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut odd_char_count = 0;
        let mut middle_char = '\0';

        for i in 0..26 {
            if counts[i] % 2 != 0 {
                odd_char_count += 1;
                middle_char = (b'a' + i as u8) as char;
            }
        }

        if odd_char_count > 1 {
            return "".to_string(); // Not possible to form a palindrome
        }

        let mut first_half = String::new();
        for i in 0..26 {
            for _ in 0..(counts[i] / 2) {
                first_half.push((b'a' + i as u8) as char);
            }
        }

        let mut result = first_half.clone();
        if middle_char != '\0' {
            result.push(middle_char);
        }

        let second_half: String = first_half.chars().rev().collect();
        result.push_str(&second_half);

        result
    }
}