use std::collections::HashSet;

impl Solution {
    pub fn distinct_names(ideas: Vec<String>) -> i64 {
        let mut suffix_groups: Vec<HashSet<String>> = vec![HashSet::new(); 26];

        for idea in ideas {
            let first_char_code = idea.as_bytes()[0] - b'a';
            let suffix = idea[1..].to_string();
            suffix_groups[first_char_code as usize].insert(suffix);
        }

        let mut total_valid_pairs: i64 = 0;

        for i in 0..26 {
            for j in 0..26 {
                if i == j {
                    continue;
                }

                let mut count_a = 0;
                for suffix_from_i in &suffix_groups[i] {
                    if !suffix_groups[j].contains(suffix_from_i) {
                        count_a += 1;
                    }
                }

                let mut count_b = 0;
                for suffix_from_j in &suffix_groups[j] {
                    if !suffix_groups[i].contains(suffix_from_j) {
                        count_b += 1;
                    }
                }

                total_valid_pairs += (count_a as i64) * (count_b as i64);
            }
        }

        total_valid_pairs
    }
}