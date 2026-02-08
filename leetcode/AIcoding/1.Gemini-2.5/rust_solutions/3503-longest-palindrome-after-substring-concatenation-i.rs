use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for word in words {
            *counts.entry(word).or_insert(0) += 1;
        }

        let mut ans = 0;
        let mut has_center_palindrome = false;

        let mut processed_words: HashSet<String> = HashSet::new();

        for (word_ref, &count) in counts.iter() {
            if processed_words.contains(word_ref) {
                continue;
            }

            let bytes = word_ref.as_bytes();
            let c1 = bytes[0];
            let c2 = bytes[1];

            // Case 1: Palindrome word (e.g., "aa")
            if c1 == c2 {
                ans += (count / 2) * 4;
                if count % 2 == 1 {
                    has_center_palindrome = true;
                }
                processed_words.insert(word_ref.clone());
            } 
            // Case 2: Non-palindrome word (e.g., "ab")
            else {
                let rev_word_bytes = [c2, c1];
                let rev_word_str = String::from_utf8(rev_word_bytes.to_vec()).unwrap();

                if let Some(&rev_count) = counts.get(&rev_word_str) {
                    let num_pairs = count.min(rev_count);
                    ans += num_pairs * 4;
                    processed_words.insert(word_ref.clone());
                    processed_words.insert(rev_word_str.clone());
                }
            }
        }

        if has_center_palindrome {
            ans += 2;
        }

        ans
    }
}