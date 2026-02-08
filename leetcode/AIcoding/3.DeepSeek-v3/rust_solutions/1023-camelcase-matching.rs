impl Solution {
    pub fn camel_match(queries: Vec<String>, pattern: String) -> Vec<bool> {
        let pattern_chars: Vec<char> = pattern.chars().collect();
        queries.into_iter().map(|query| {
            let query_chars: Vec<char> = query.chars().collect();
            let mut i = 0;
            for &c in query_chars.iter() {
                if i < pattern_chars.len() && c == pattern_chars[i] {
                    i += 1;
                } else if c.is_uppercase() {
                    return false;
                }
            }
            i == pattern_chars.len()
        }).collect()
    }
}