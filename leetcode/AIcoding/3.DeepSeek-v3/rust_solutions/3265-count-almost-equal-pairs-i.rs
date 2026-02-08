use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(words: Vec<String>) -> i32 {
        let mut freq = HashMap::new();
        let mut count = 0;
        for word in words {
            let key = word.chars().collect::<Vec<char>>();
            for (k, v) in freq.iter() {
                if Self::is_almost_equal(&key, k) {
                    count += v;
                }
            }
            *freq.entry(key).or_insert(0) += 1;
        }
        count
    }

    fn is_almost_equal(a: &[char], b: &[char]) -> bool {
        if a.len() != b.len() {
            return false;
        }
        let mut diff = 0;
        for (c1, c2) in a.iter().zip(b.iter()) {
            if c1 != c2 {
                diff += 1;
                if diff > 2 {
                    return false;
                }
            }
        }
        diff <= 2
    }
}