impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        let mut seen = std::collections::HashSet::new();
        let mut repeated = std::collections::HashSet::new();
        let mut result = Vec::new();

        if s.len() < 10 {
            return result;
        }

        for i in 0..=s.len() - 10 {
            let sub = &s[i..i + 10];
            if seen.contains(sub) {
                if !repeated.contains(sub) {
                    result.push(sub.to_string());
                    repeated.insert(sub.to_string());
                }
            } else {
                seen.insert(sub.to_string());
            }
        }

        result
    }
}