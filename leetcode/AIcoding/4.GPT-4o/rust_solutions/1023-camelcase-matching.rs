impl Solution {
    pub fn camel_match(queries: Vec<String>, pattern: String) -> Vec<bool> {
        let is_match = |query: &str, pattern: &str| {
            let mut j = 0;
            for c in query.chars() {
                if j < pattern.len() && c == pattern.chars().nth(j).unwrap() {
                    j += 1;
                } else if c.is_uppercase() {
                    return false;
                }
            }
            j == pattern.len()
        };
        queries.iter().map(|q| is_match(q, &pattern)).collect()
    }
}