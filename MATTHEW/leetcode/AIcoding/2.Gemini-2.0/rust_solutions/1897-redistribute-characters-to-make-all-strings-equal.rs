impl Solution {
    pub fn make_equal(words: Vec<String>) -> bool {
        let n = words.len();
        let mut counts = std::collections::HashMap::new();
        for word in &words {
            for c in word.chars() {
                *counts.entry(c).or_insert(0) += 1;
            }
        }
        for (_, count) in counts {
            if count % n != 0 {
                return false;
            }
        }
        true
    }
}