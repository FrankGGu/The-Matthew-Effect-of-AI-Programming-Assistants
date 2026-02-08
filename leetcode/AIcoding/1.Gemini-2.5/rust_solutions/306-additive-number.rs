impl Solution {
    pub fn is_additive_number(num: String) -> bool {
        let n = num.len();
        if n < 3 {
            return false;
        }

        // Iterate for the length of the first number (num1_len)
        // num1_len can be from 1 up to n-2 (to leave at least 1 digit for num2 and 1 for sum)
        for num1_len in 1..=(n / 2) { // Optimization: num1_len cannot be more than half the string length
            // Check for leading zeros for the first number
            if num1_len > 1 && num.as_bytes()[0] == b'0' {
                break; // Invalid first number, no need to continue with longer first numbers
            }
            let num1_str = &num[0..num1_len];

            // Iterate for the length of the second number (num2_len)
            // num2_len can be from 1 up to n - num1_len - 1
            // Also, num2_len cannot be more than half of the remaining string (n - num1_len)
            for num2_len in 1..=(n - num1_len) / 2 { // Optimization: num2_len cannot be more than half the remaining string
                // Check if there's enough space for the third number (sum)
                if num1_len + num2_len >= n {
                    continue;
                }

                // Check for leading zeros for the second number
                if num2_len > 1 && num.as_bytes()[num1_len] == b'0' {
                    break; // Invalid second number, no need to continue with longer second numbers starting at this position
                }
                let num2_str = &num[num1_len..num1_len + num2_len];

                // Now, call a helper function to check the rest of the string
                // The remaining string starts at index num1_len + num2_len
                if Self::check(&num, num1_len + num2_len, num1_str, num2_str) {
                    return true;
                }
            }
        }
        false
    }

    // Helper function for string addition
    fn add_strings(s1: &str, s2: &str) -> String {
        let mut res_chars = Vec::new();
        let mut i = s1.len();
        let mut j = s2.len();
        let mut carry = 0;

        while i > 0 || j > 0 || carry > 0 {
            let mut sum = carry;
            if i > 0 {
                i -= 1;
                sum += (s1.as_bytes()[i] - b'0') as u32;
            }
            if j > 0 {
                j -= 1;
                sum += (s2.as_bytes()[j] - b'0') as u32;
            }

            carry = sum / 10;
            res_chars.push((b'0' + (sum % 10) as u8) as char);
        }
        res_chars.into_iter().rev().collect() // Reverse the result as we built it from least significant digit
    }

    // Recursive helper function
    fn check(num_str_ref: &str, start_idx: usize, prev1_str: &str, prev2_str: &str) -> bool {
        if start_idx == num_str_ref.len() {
            return true; // Successfully parsed the entire string
        }

        let sum_str = Self::add_strings(prev1_str, prev2_str);

        // Check if the remaining part of num_str_ref starts with sum_str
        if num_str_ref[start_idx..].starts_with(&sum_str) {
            // Recursively call with updated parameters
            Self::check(num_str_ref, start_idx + sum_str.len(), prev2_str, &sum_str)
        } else {
            false
        }
    }
}