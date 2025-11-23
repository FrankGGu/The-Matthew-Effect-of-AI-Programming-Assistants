impl Solution {
    pub fn count_consistent_strings(allowed: String, words: Vec<String>) -> i32 {
        let allowed_set: std::collections::HashSet<char> = allowed.chars().collect();
        let mut count = 0;
        for word in words {
            let mut consistent = true;
            for c in word.chars() {
                if !allowed_set.contains(&c) {
                    consistent = false;
                    break;
                }
            }
            if consistent {
                count += 1;
            }
        }
        count
    }
}