impl Solution {
    pub fn odd_string_diff(words: Vec<String>) -> String {
        let mut diff_map = std::collections::HashMap::new();

        for word in &words {
            let mut diffs = vec![];
            for i in 1..word.len() {
                diffs.push((word.as_bytes()[i] - word.as_bytes()[i - 1]) as i32);
            }
            diff_map.entry(diffs).or_insert(word);
        }

        for (_, word) in diff_map {
            if diff_map.len() == 1 || diff_map.len() > 1 && words.iter().filter(|&&w| w != word).count() == 1 {
                return word.clone();
            }
        }

        String::new()
    }
}