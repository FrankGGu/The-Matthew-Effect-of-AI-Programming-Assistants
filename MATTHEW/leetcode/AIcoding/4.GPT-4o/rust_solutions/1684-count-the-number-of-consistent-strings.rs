impl Solution {
    pub fn count_consistent_strings(allowed: String, words: Vec<String>) -> i32 {
        let allowed_set: std::collections::HashSet<char> = allowed.chars().collect();
        words.iter().filter(|word| word.chars().all(|c| allowed_set.contains(&c))).count() as i32
    }
}