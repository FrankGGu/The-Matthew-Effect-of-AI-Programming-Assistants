use std::collections::HashSet;

impl Solution {
    pub fn num_special_equiv_groups(words: Vec<String>) -> i32 {
        let mut unique_groups: HashSet<([i32; 26], [i32; 26])> = HashSet::new();

        for word in words {
            let mut even_counts = [0; 26];
            let mut odd_counts = [0; 26];

            for (i, c) in word.chars().enumerate() {
                let char_idx = (c as u8 - b'a') as usize;
                if i % 2 == 0 {
                    even_counts[char_idx] += 1;
                } else {
                    odd_counts[char_idx] += 1;
                }
            }
            unique_groups.insert((even_counts, odd_counts));
        }

        unique_groups.len() as i32
    }
}