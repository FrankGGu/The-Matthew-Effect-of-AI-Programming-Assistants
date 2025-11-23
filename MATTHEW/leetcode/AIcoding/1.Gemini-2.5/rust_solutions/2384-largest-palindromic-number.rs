impl Solution {
    pub fn largest_palindromic(num: String) -> String {
        let mut counts = [0; 10];
        for c in num.chars() {
            counts[c.to_digit(10).unwrap() as usize] += 1;
        }

        let mut left_half_str_builder = String::new();
        // Build the left half of the palindrome by iterating digits from '9' down to '0'.
        // For each digit, append `count / 2` times to the builder.
        for d_idx in (0..=9).rev() {
            let d = (d_idx as u8 + b'0') as char;
            let num_pairs = counts[d_idx] / 2;
            left_half_str_builder.push_str(&d.to_string().repeat(num_pairs));
            counts[d_idx] %= 2; // Update count for remaining single digits
        }

        // Find the middle digit. This should be the largest available single digit.
        let mut middle_char: Option<char> = None;
        for d_idx in (0..=9).rev() {
            if counts[d_idx] == 1 {
                middle_char = Some((d_idx as u8 + b'0') as char);
                break;
            }
        }

        let mut result = String::new();
        result.push_str(&left_half_str_builder);
        if let Some(c) = middle_char {
            result.push(c);
        }
        let right_half_str: String = left_half_str_builder.chars().rev().collect();
        result.push_str(&right_half_str);

        // Handle edge cases for "0" and leading zeros.
        // If the resulting palindrome consists only of '0's (e.g., "0", "00", "000"), return "0".
        // Otherwise, return the constructed palindrome.
        if result.is_empty() {
            "0".to_string()
        } else if result.chars().all(|c| c == '0') {
            "0".to_string()
        } else {
            result
        }
    }
}