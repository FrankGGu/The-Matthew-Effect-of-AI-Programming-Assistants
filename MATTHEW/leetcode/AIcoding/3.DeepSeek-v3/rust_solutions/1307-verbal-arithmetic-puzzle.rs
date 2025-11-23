use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn is_solvable(words: Vec<String>, result: String) -> bool {
        let mut all_words = words;
        all_words.push(result);
        let mut leading_chars = HashSet::new();
        for word in &all_words {
            if let Some(c) = word.chars().next() {
                leading_chars.insert(c);
            }
        }
        let mut unique_chars = Vec::new();
        let mut char_set = HashSet::new();
        for word in &all_words {
            for c in word.chars() {
                if !char_set.contains(&c) {
                    char_set.insert(c);
                    unique_chars.push(c);
                }
            }
        }
        let n = unique_chars.len();
        let mut char_to_digit = HashMap::new();
        let mut used_digits = [false; 10];
        Self::backtrack(
            &unique_chars,
            0,
            &mut char_to_digit,
            &mut used_digits,
            &words,
            &result,
            &leading_chars,
            n,
        )
    }

    fn backtrack(
        unique_chars: &Vec<char>,
        pos: usize,
        char_to_digit: &mut HashMap<char, i32>,
        used_digits: &mut [bool; 10],
        words: &[String],
        result: &String,
        leading_chars: &HashSet<char>,
        total_chars: usize,
    ) -> bool {
        if pos == total_chars {
            let sum_words = words.iter().fold(0, |acc, word| {
                acc + word.chars().fold(0, |num, c| num * 10 + char_to_digit[&c])
            });
            let sum_result = result.chars().fold(0, |num, c| num * 10 + char_to_digit[&c]);
            return sum_words == sum_result;
        }
        let c = unique_chars[pos];
        let start = if leading_chars.contains(&c) { 1 } else { 0 };
        for d in start..10 {
            if !used_digits[d] {
                char_to_digit.insert(c, d as i32);
                used_digits[d] = true;
                if Self::backtrack(
                    unique_chars,
                    pos + 1,
                    char_to_digit,
                    used_digits,
                    words,
                    result,
                    leading_chars,
                    total_chars,
                ) {
                    return true;
                }
                used_digits[d] = false;
                char_to_digit.remove(&c);
            }
        }
        false
    }
}