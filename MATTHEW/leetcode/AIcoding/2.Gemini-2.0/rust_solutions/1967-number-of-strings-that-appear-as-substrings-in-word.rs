impl Solution {
    pub fn num_of_strings(patterns: Vec<String>, word: String) -> i32 {
        let mut count = 0;
        for pattern in patterns {
            if word.contains(&pattern) {
                count += 1;
            }
        }
        count
    }
}