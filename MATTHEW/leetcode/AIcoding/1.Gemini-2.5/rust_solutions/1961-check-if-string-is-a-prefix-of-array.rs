impl Solution {
    pub fn is_prefix_of_array(s: String, words: Vec<String>) -> bool {
        let mut current_prefix = String::new();
        for word in words {
            current_prefix.push_str(&word);
            if current_prefix == s {
                return true;
            }
            if current_prefix.len() >= s.len() {
                return false;
            }
        }
        false
    }
}