impl Solution {
    pub fn string_matching(words: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        for i in 0..words.len() {
            for j in 0..words.len() {
                if i != j && words[j].contains(&words[i]) {
                    if !result.contains(&words[i]) {
                        result.push(words[i].clone());
                    }
                }
            }
        }
        result
    }
}