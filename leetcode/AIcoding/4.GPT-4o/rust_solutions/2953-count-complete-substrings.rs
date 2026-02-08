impl Solution {
    pub fn count_complete_substrings(s: String) -> i32 {
        let n = s.len();
        let unique_chars: std::collections::HashSet<char> = s.chars().collect();
        let total_unique = unique_chars.len();
        let mut count = 0;

        for start in 0..n {
            let mut char_count = std::collections::HashMap::new();
            let mut current_unique = 0;

            for end in start..n {
                let c = s.chars().nth(end).unwrap();
                *char_count.entry(c).or_insert(0) += 1;
                if char_count[c] == 1 {
                    current_unique += 1;
                }

                if current_unique == total_unique {
                    count += 1;
                }
            }
        }

        count
    }
}