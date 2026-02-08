impl Solution {
    pub fn longest_common_prefix(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return String::new();
        }

        let first_str = &strs[0];
        for (i, c) in first_str.chars().enumerate() {
            for str in &strs {
                if i >= str.len() || str.chars().nth(i) != Some(c) {
                    return first_str[..i].to_string();
                }
            }
        }

        first_str.to_string()
    }
}