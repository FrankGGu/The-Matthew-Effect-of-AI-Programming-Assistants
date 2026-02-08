impl Solution {
    pub fn longest_valid_parentheses(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut max_len = 0;

        // First pass: Left to right
        let mut left_count = 0;
        let mut right_count = 0;
        for i in 0..n {
            if chars[i] == '(' {
                left_count += 1;
            } else {
                right_count += 1;
            }

            if left_count == right_count {
                max_len = max_len.max(2 * left_count);
            } else if right_count > left_count {
                // More ')' than '(', invalid sequence, reset counts
                left_count = 0;
                right_count = 0;
            }
        }

        // Second pass: Right to left
        left_count = 0;
        right_count = 0;
        for i in (0..n).rev() {
            if chars[i] == '(' {
                left_count += 1;
            } else {
                right_count += 1;
            }

            if left_count == right_count {
                max_len = max_len.max(2 * left_count);
            } else if left_count > right_count {
                // More '(' than ')', invalid sequence, reset counts
                left_count = 0;
                right_count = 0;
            }
        }

        max_len
    }
}