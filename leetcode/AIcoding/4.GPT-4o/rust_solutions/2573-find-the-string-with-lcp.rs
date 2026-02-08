pub fn find_lcp(strings: Vec<String>) -> String {
    if strings.is_empty() {
        return "".to_string();
    }

    let mut longest_prefix = strings[0].clone();

    for s in strings.iter().skip(1) {
        while !s.starts_with(&longest_prefix) {
            longest_prefix.pop();
            if longest_prefix.is_empty() {
                return "".to_string();
            }
        }
    }

    longest_prefix
}