use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn is_solvable(words: Vec<String>, result: String) -> bool {
        let mut unique_chars_set = HashSet::new();
        let mut leading_chars = HashSet::new();

        for word in &words {
            for c in word.chars() {
                unique_chars_set.insert(c);
            }
            if word.len() > 1 {
                leading_chars.insert(word.chars().next().unwrap());
            }
        }
        for c in result.chars() {
            unique_chars_set.insert(c);
        }
        if result.len() > 1 {
            leading_chars.insert(result.chars().next().unwrap());
        }

        let chars_vec: Vec<char> = unique_chars_set.into_iter().collect();

        let mut char_to_digit: HashMap<char, i32> = HashMap::new();
        let mut digit_used: [bool; 10] = [false; 10];

        Self::backtrack(
            0,
            &chars_vec,
            &mut char_to_digit,
            &mut digit_used,
            &leading_chars,
            &words,
            &result,
        )
    }

    fn backtrack(
        char_idx: usize,
        chars: &[char],
        char_to_digit: &mut HashMap<char, i32>,
        digit_used: &mut [bool; 10],
        leading_chars: &HashSet<char>,
        words: &[String],
        result: &String,
    ) -> bool {
        if char_idx == chars.len() {
            let mut sum: i64 = 0;
            for word in words {
                sum += Self::get_value(word, char_to_digit);
            }
            let result_value = Self::get_value(result, char_to_digit);
            return sum == result_value;
        }

        let current_char = chars[char_idx];

        for digit in 0..10 {
            if digit_used[digit as usize] {
                continue;
            }
            if leading_chars.contains(&current_char) && digit == 0 {
                continue;
            }

            char_to_digit.insert(current_char, digit);
            digit_used[digit as usize] = true;

            if Self::backtrack(
                char_idx + 1,
                chars,
                char_to_digit,
                digit_used,
                leading_chars,
                words,
                result,
            ) {
                return true;
            }

            digit_used[digit as usize] = false;
            char_to_digit.remove(&current_char);
        }

        false
    }

    fn get_value(word: &str, char_to_digit: &HashMap<char, i32>) -> i64 {
        let mut value: i64 = 0;
        for c in word.chars() {
            value = value * 10 + char_to_digit[&c] as i64;
        }
        value
    }
}