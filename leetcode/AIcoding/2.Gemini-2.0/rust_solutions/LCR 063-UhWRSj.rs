impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let mut root_set = std::collections::HashSet::new();
        for word in dictionary {
            root_set.insert(word);
        }

        let words: Vec<&str> = sentence.split_whitespace().collect();
        let mut result = Vec::new();

        for word in words {
            let mut found_root = None;
            for i in 1..=word.len() {
                let prefix = &word[0..i];
                if root_set.contains(prefix) {
                    found_root = Some(prefix.to_string());
                    break;
                }
            }

            if let Some(root) = found_root {
                result.push(root);
            } else {
                result.push(word.to_string());
            }
        }

        result.join(" ")
    }
}