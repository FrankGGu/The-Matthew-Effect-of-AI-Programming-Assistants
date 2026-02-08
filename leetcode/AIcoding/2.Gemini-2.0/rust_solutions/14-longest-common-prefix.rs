impl Solution {
    pub fn longest_common_prefix(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return String::new();
        }

        let first = &strs[0];
        let mut prefix = String::new();

        for (i, c) in first.chars().enumerate() {
            let mut match_all = true;
            for str in &strs {
                if i >= str.len() || str.chars().nth(i) != Some(c) {
                    match_all = false;
                    break;
                }
            }

            if match_all {
                prefix.push(c);
            } else {
                break;
            }
        }

        prefix
    }
}