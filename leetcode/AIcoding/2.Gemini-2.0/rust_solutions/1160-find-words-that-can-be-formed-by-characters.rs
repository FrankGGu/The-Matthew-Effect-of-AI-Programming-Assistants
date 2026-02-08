impl Solution {
    pub fn count_characters(words: Vec<String>, chars: String) -> i32 {
        let mut char_counts = std::collections::HashMap::new();
        for c in chars.chars() {
            *char_counts.entry(c).or_insert(0) += 1;
        }

        let mut count = 0;
        for word in words {
            let mut word_counts = std::collections::HashMap::new();
            let mut possible = true;
            for c in word.chars() {
                *word_counts.entry(c).or_insert(0) += 1;
                if word_counts[&c] > *char_counts.get(&c).unwrap_or(&0) {
                    possible = false;
                    break;
                }
            }
            if possible {
                count += word.len() as i32;
            }
        }
        count
    }
}