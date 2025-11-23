use std::collections::HashMap;

impl Solution {
    pub fn palindrome_pairs(words: Vec<String>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut word_map = HashMap::new();

        for (i, word) in words.iter().enumerate() {
            word_map.insert(word.clone(), i);
        }

        for (i, word) in words.iter().enumerate() {
            let len = word.len();
            for j in 0..=len {
                let left = &word[0..j];
                let right = &word[j..len];

                if Self::is_palindrome(left) {
                    if let Some(&k) = word_map.get(&right.chars().rev().collect::<String>()) {
                        if k != i {
                            result.push(vec![k as i32, i as i32]);
                        }
                    }
                }

                if j != len && Self::is_palindrome(right) {
                    if let Some(&k) = word_map.get(&left.chars().rev().collect::<String>()) {
                        if k != i {
                            result.push(vec![i as i32, k as i32]);
                        }
                    }
                }
            }
        }

        result
    }

    fn is_palindrome(s: &str) -> bool {
        let bytes = s.as_bytes();
        let mut left = 0;
        let mut right = bytes.len() as i32 - 1;
        while left < right {
            if bytes[left as usize] != bytes[right as usize] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}