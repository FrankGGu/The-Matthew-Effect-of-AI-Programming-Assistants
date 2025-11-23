impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_longest_uncommon_subsequence(sequences: Vec<String>) -> String {
        fn is_subsequence(s: &str, t: &str) -> bool {
            let mut it = t.chars();
            s.chars().all(|c| it.find(|&ch| ch == c))
        }

        let mut unique_sequences = HashSet::new();
        let mut duplicates = HashSet::new();

        for seq in &sequences {
            if !unique_sequences.insert(seq) {
                duplicates.insert(seq);
            }
        }

        let mut max_len = -1;
        let mut result = String::new();

        for seq in sequences {
            if duplicates.contains(&seq) {
                continue;
            }

            let is_uncommon = sequences.iter().all(|other| {
                if other == &seq {
                    true
                } else {
                    !is_subsequence(&seq, other)
                }
            });

            if is_uncommon {
                if seq.len() > max_len {
                    max_len = seq.len() as isize;
                    result = seq;
                }
            }
        }

        result
    }
}
}