impl Solution {
    pub fn find_and_replace_pattern(words: Vec<String>, pattern: String) -> Vec<String> {
        let mut result = Vec::new();
        for word in words {
            if Solution::matches(&word, &pattern) {
                result.push(word);
            }
        }
        result
    }

    fn matches(word: &String, pattern: &String) -> bool {
        if word.len() != pattern.len() {
            return false;
        }

        let mut map1 = std::collections::HashMap::new();
        let mut map2 = std::collections::HashMap::new();

        for (c1, c2) in word.chars().zip(pattern.chars()) {
            if !map1.contains_key(&c1) {
                map1.insert(c1, c2);
            }
            if !map2.contains_key(&c2) {
                map2.insert(c2, c1);
            }

            if map1[&c1] != c2 || map2[&c2] != c1 {
                return false;
            }
        }

        true
    }
}