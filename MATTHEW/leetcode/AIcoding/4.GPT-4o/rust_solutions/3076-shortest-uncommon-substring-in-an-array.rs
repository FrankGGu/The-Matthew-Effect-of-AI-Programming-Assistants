impl Solution {
    pub fn shortest_uncommon_substring(arr: Vec<String>) -> String {
        let mut result = String::new();
        let mut seen = std::collections::HashSet::new();

        for s in &arr {
            seen.insert(s.as_str());
        }

        for len in 1..=20 {
            let mut found = false;
            let mut candidates = std::collections::HashSet::new();

            for s in &arr {
                for i in 0..=s.len() - len {
                    let sub = &s[i..i + len];
                    candidates.insert(sub);
                }
            }

            for candidate in &candidates {
                if !seen.contains(candidate) {
                    result = candidate.to_string();
                    found = true;
                    break;
                }
            }

            if found {
                break;
            }
        }

        result
    }
}