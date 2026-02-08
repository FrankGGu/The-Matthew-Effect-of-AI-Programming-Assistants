use std::collections::HashSet;

impl Solution {
    pub fn num_different_integers(word: String) -> i32 {
        let mut set = HashSet::new();
        let chars: Vec<char> = word.chars().collect();
        let mut i = 0;
        let n = chars.len();

        while i < n {
            if chars[i].is_digit(10) {
                let mut j = i;
                while j < n && chars[j].is_digit(10) {
                    j += 1;
                }
                let num_str = &word[i..j];
                let num = num_str.trim_start_matches('0');
                if num.is_empty() {
                    set.insert("0");
                } else {
                    set.insert(num);
                }
                i = j;
            } else {
                i += 1;
            }
        }

        set.len() as i32
    }
}