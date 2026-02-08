use std::collections::HashMap;

impl Solution {
    pub fn longest_special_substring(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return -1;
        }

        let mut char_blocks: HashMap<char, Vec<usize>> = HashMap::new();
        let chars: Vec<char> = s.chars().collect();

        let mut i = 0;
        while i < n {
            let current_char = chars[i];
            let mut current_len = 0;
            let mut j = i;
            while j < n && chars[j] == current_char {
                current_len += 1;
                j += 1;
            }
            char_blocks.entry(current_char).or_insert(Vec::new()).push(current_len);
            i = j;
        }

        let mut max_len = -1;

        for (_, lengths) in char_blocks.iter_mut() {
            lengths.sort_unstable_by(|a, b| b.cmp(a)); // Sort descending

            for k in (1..=n).rev() { // Iterate potential substring lengths from largest possible down to 1
                let mut current_count = 0;
                for &block_len in lengths.iter() {
                    if block_len >= k {
                        current_count += (block_len - k + 1);
                    } else {
                        // Since lengths are sorted descending, no further blocks will be long enough.
                        break;
                    }
                }

                if current_count >= 3 {
                    max_len = max_len.max(k as i32);
                    // Since we are iterating k downwards, the first k we find for this character
                    // will be the longest possible for this character. We can break and check other characters.
                    break;
                }
            }
        }

        max_len
    }
}