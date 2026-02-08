impl Solution {
    pub fn longest_common_prefix(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return String::new();
        }
        let first_str = &strs[0];
        let mut prefix_len = first_str.len();
        for s in strs.iter().skip(1) {
            let mut current_len = 0;
            for (c1, c2) in first_str.chars().zip(s.chars()) {
                if c1 == c2 {
                    current_len += 1;
                } else {
                    break;
                }
            }
            prefix_len = prefix_len.min(current_len);
            if prefix_len == 0 {
                break;
            }
        }
        first_str[..prefix_len].to_string()
    }
}