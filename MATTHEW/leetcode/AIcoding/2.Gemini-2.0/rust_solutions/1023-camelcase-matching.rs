impl Solution {
    pub fn camel_match(queries: Vec<String>, pattern: String) -> Vec<bool> {
        let mut result = Vec::new();
        for query in queries {
            result.push(Self::is_match(&query, &pattern));
        }
        result
    }

    fn is_match(query: &str, pattern: &str) -> bool {
        let mut pattern_idx = 0;
        for query_char in query.chars() {
            if pattern_idx < pattern.len() && query_char == pattern.chars().nth(pattern_idx).unwrap() {
                pattern_idx += 1;
            } else if query_char.is_uppercase() {
                return false;
            }
        }
        pattern_idx == pattern.len()
    }
}