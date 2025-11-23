use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn palindrome_pairs(words: Vec<String>) -> Vec<Vec<i32>> {
        let mut word_map: HashMap<String, usize> = HashMap::new();
        for (i, word) in words.iter().enumerate() {
            word_map.insert(word.clone(), i);
        }

        let mut results: HashSet<(i32, i32)> = HashSet::new();

        for (i, s1) in words.iter().enumerate() {
            let s1_len = s1.len();

            for k in 0..=s1_len {
                let left = &s1[0..k];
                let right = &s1[k..];

                // Case 1: words[j] + words[i] forms a palindrome.
                // This happens if 'left' is a palindrome, and 'words[j]' is 'right.reversed()'.
                // Example: words[i] = "abcba", words[j] = "cba".
                // Split "abcba" into "ab" (left) and "cba" (right).
                // If "ab" is a palindrome (false), skip.
                // If "a" (left) is a palindrome (true), and "bcba".reversed()="abcb" exists as words[j], then add [j, i].
                // If "" (left) is a palindrome (true), and "abcba".reversed()="abcb" exists as words[j], then add [j, i].
                if Self::is_palindrome(left) {
                    let right_rev: String = right.chars().rev().collect();
                    if let Some(&j) = word_map.get(&right_rev) {
                        if i != j {
                            results.insert((j as i32, i as i32));
                        }
                    }
                }

                // Case 2: words[i] + words[j] forms a palindrome.
                // This happens if 'right' is a palindrome, and 'words[j]' is 'left.reversed()'.
                // Example: words[i] = "abac", words[j] = "ba".
                // Split "abac" into "aba" (left) and "c" (right).
                // If "c" is a palindrome (true), and "aba".reversed()="aba" exists as words[j], then add [i, j].
                // If "ac" (right) is a palindrome (false), skip.
                // If "" (right) is a palindrome (true), and "abac".reversed()="caba" exists as words[j], then add [i, j].
                if Self::is_palindrome(right) {
                    let left_rev: String = left.chars().rev().collect();
                    if let Some(&j) = word_map.get(&left_rev) {
                        if i != j {
                            results.insert((i as i32, j as i32));
                        }
                    }
                }
            }
        }

        results.into_iter().map(|(x, y)| vec![x, y]).collect()
    }

    // Helper function to check if a string slice is a palindrome.
    // An empty string is considered a palindrome.
    fn is_palindrome(s: &str) -> bool {
        s.chars().eq(s.chars().rev())
    }
}