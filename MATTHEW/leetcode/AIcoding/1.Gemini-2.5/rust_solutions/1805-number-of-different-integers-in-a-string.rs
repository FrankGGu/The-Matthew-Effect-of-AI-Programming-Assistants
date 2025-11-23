use std::collections::HashSet;

impl Solution {
    pub fn num_different_integers(word: String) -> i32 {
        let mut unique_numbers: HashSet<String> = HashSet::new();
        let chars: Vec<char> = word.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            if chars[i].is_ascii_digit() {
                let mut j = i;
                while j < n && chars[j].is_ascii_digit() {
                    j += 1;
                }

                // Extract the number string
                let num_str: String = chars[i..j].iter().collect();

                // Remove leading zeros to get the canonical form
                let mut k = 0;
                // Keep incrementing k as long as it's not the last character and it's '0'
                while k < num_str.len() - 1 && num_str.chars().nth(k).unwrap() == '0' {
                    k += 1;
                }

                let canonical_num_str = num_str[k..].to_string();
                unique_numbers.insert(canonical_num_str);

                // Move the outer loop pointer past the current number
                i = j; 
            } else {
                // If it's not a digit, just move to the next character
                i += 1; 
            }
        }

        unique_numbers.len() as i32
    }
}