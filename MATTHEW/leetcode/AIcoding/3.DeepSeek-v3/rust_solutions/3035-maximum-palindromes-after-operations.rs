use std::collections::HashMap;

impl Solution {
    pub fn max_palindromes_after_operations(words: Vec<String>) -> i32 {
        let mut freq = HashMap::new();
        for word in words.iter() {
            for c in word.chars() {
                *freq.entry(c).or_insert(0) += 1;
            }
        }

        let mut pairs = 0;
        let mut odd = 0;
        for &count in freq.values() {
            pairs += count / 2;
            odd += count % 2;
        }

        let mut word_lens: Vec<usize> = words.iter().map(|word| word.len()).collect();
        word_lens.sort_unstable();

        let mut res = 0;
        for len in word_lens {
            let pairs_needed = len / 2;
            if pairs >= pairs_needed {
                pairs -= pairs_needed;
                if len % 2 == 1 {
                    if odd > 0 {
                        odd -= 1;
                    } else {
                        if pairs > 0 {
                            pairs -= 1;
                            odd += 1;
                        } else {
                            continue;
                        }
                    }
                }
                res += 1;
            } else {
                break;
            }
        }
        res
    }
}