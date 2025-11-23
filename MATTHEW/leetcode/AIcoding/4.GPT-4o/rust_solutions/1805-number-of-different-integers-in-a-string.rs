use std::collections::HashSet;

impl Solution {
    pub fn num_different_integers(word: String) -> i32 {
        let mut nums = HashSet::new();
        let mut current_num = String::new();

        for c in word.chars() {
            if c.is_digit(10) {
                current_num.push(c);
            } else {
                if !current_num.is_empty() {
                    nums.insert(current_num.trim_start_matches('0').to_string());
                    current_num.clear();
                }
            }
        }

        if !current_num.is_empty() {
            nums.insert(current_num.trim_start_matches('0').to_string());
        }

        nums.len() as i32
    }
}