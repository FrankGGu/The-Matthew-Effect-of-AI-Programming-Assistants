impl Solution {
    pub fn two_edit_words(queries: Vec<String>, dictionary: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        for query in &queries {
            for dict_word in &dictionary {
                let mut diff = 0;
                for i in 0..query.len() {
                    if query.chars().nth(i) != dict_word.chars().nth(i) {
                        diff += 1;
                    }
                }
                if diff <= 2 {
                    result.push(query.clone());
                    break;
                }
            }
        }
        result
    }
}