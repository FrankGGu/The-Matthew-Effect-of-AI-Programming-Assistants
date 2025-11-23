impl Solution {
    pub fn maximum_number_of_string_pairs(words: Vec<String>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        let mut pairs = 0;

        for word in words.iter() {
            let rev = word.chars().rev().collect::<String>();
            if seen.contains(&rev) {
                pairs += 1;
                seen.remove(&rev);
            } else {
                seen.insert(word.clone());
            }
        }

        pairs
    }
}