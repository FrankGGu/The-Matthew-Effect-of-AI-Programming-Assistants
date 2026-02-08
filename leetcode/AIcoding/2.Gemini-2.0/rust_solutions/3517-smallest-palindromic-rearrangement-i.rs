impl Solution {
    pub fn smallest_palindromic_rearrangement(s: String) -> String {
        let mut counts = std::collections::HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut odd_count = 0;
        let mut odd_char = None;
        for (&c, &count) in &counts {
            if count % 2 != 0 {
                odd_count += 1;
                odd_char = Some(c);
            }
        }

        if odd_count > 1 {
            return String::new();
        }

        let mut result = String::new();
        let mut chars: Vec<char> = counts.keys().cloned().collect();
        chars.sort();

        for c in chars {
            let count = counts.get(&c).unwrap();
            for _ in 0..(count / 2) {
                result.push(c);
            }
        }

        let mut reversed_result = result.chars().rev().collect::<String>();
        if let Some(c) = odd_char {
            let count = counts.get(&c).unwrap();
            for _ in 0..*count {
                result.push(c);
            }
        }

        result.push_str(&reversed_result);
        result
    }
}