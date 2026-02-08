use std::collections::HashMap;

impl Solution {
    pub fn palindrome_pairs(words: Vec<String>) -> Vec<Vec<i32>> {
        let mut word_map = HashMap::new();
        for (i, word) in words.iter().enumerate() {
            word_map.insert(word.clone(), i);
        }

        let mut result = Vec::new();

        for (i, word) in words.iter().enumerate() {
            let n = word.len();
            let rev_word: String = word.chars().rev().collect();

            if let Some(&j) = word_map.get(&rev_word) {
                if i != j {
                    result.push(vec![i as i32, j as i32]);
                }
            }

            for k in 0..n {
                if word[..k].chars().rev().collect::<String>() == word[k..] {
                    let suffix_rev: String = word[..k].chars().rev().collect();
                    if let Some(&j) = word_map.get(&suffix_rev) {
                        if i != j {
                            result.push(vec![i as i32, j as i32]);
                        }
                    }
                }

                if word[k..].chars().rev().collect::<String>() == word[..k] {
                    let prefix_rev: String = word[k..].chars().rev().collect();
                    if let Some(&j) = word_map.get(&prefix_rev) {
                        if i != j {
                            result.push(vec![j as i32, i as i32]);
                        }
                    }
                }
            }
        }

        result
    }
}