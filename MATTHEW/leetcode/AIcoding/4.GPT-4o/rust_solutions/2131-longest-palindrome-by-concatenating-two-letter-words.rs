impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        use std::collections::HashMap;
        let mut count = HashMap::new();
        let mut length = 0;
        let mut has_center = false;

        for word in words {
            *count.entry(word.clone()).or_insert(0) += 1;
        }

        for (word, cnt) in count.iter() {
            let rev_word = word.chars().rev().collect::<String>();
            if word == &rev_word {
                if cnt % 2 == 0 {
                    length += cnt * 2;
                } else {
                    length += (cnt - 1) * 2;
                    has_center = true;
                }
            } else if count.contains_key(&rev_word) {
                length += 2 * cnt.min(count[&rev_word]);
            }
        }

        if has_center {
            length += 2;
        }

        length
    }
}