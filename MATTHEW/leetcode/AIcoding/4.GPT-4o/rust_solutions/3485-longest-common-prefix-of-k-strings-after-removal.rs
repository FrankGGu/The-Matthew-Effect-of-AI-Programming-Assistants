pub fn longest_common_prefix(strs: Vec<String>) -> String {
    if strs.is_empty() {
        return "".to_string();
    }

    let mut prefix = strs[0].clone();

    for s in &strs[1..] {
        while !s.starts_with(&prefix) {
            prefix.truncate(prefix.len() - 1);
            if prefix.is_empty() {
                return "".to_string();
            }
        }
    }

    prefix
}