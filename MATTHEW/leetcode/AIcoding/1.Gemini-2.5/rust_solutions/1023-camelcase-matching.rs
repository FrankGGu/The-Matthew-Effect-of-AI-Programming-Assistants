impl Solution {
    pub fn camel_match(queries: Vec<String>, pattern: String) -> Vec<bool> {
        let mut results = Vec::with_capacity(queries.len());
        let pattern_chars: Vec<char> = pattern.chars().collect();

        for query in queries {
            let query_chars: Vec<char> = query.chars().collect();
            let mut i = 0; // pointer for query
            let mut j = 0; // pointer for pattern
            let mut is_match = true;

            while i < query_chars.len() {
                if j < pattern_chars.len() && query_chars[i] == pattern_chars[j] {
                    j += 1;
                    i += 1;
                } else if query_chars[i].is_ascii_lowercase() {
                    i += 1;
                } else {
                    is_match = false;
                    break;
                }
            }

            if j < pattern_chars.len() {
                is_match = false;
            }

            results.push(is_match);
        }
        results
    }
}