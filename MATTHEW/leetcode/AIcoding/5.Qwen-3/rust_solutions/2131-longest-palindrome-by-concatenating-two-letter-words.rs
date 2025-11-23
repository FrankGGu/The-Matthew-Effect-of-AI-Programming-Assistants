impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(mut words: Vec<String>) -> i32 {
        let mut count = HashMap::new();
        for word in &words {
            *count.entry(word).or_insert(0) += 1;
        }

        let mut palindrome_length = 0;
        let mut middle_used = false;

        for (word, &mut freq) in &mut count {
            let reversed = word.chars().rev().collect::<String>();
            if word == &reversed {
                if freq % 2 == 1 && !middle_used {
                    palindrome_length += 1;
                    middle_used = true;
                }
                palindrome_length += freq / 2 * 2;
            } else {
                let rev_count = count.get(&reversed).unwrap_or(&0);
                let min_count = std::cmp::min(freq, *rev_count);
                palindrome_length += min_count * 2;
                *count.get_mut(&reversed).unwrap() -= min_count;
            }
        }

        palindrome_length * 2
    }
}
}