use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn max_freq(s: String, max_letters: i32, min_length: i32, max_length: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        if n == 0 || min_length == 0 {
            return 0;
        }

        let min_len_usize = min_length as usize;

        let mut counts: HashMap<String, i32> = HashMap::new();
        let mut max_occurrences = 0;

        let mut freq: [i32; 26] = [0; 26];
        let mut unique_count = 0;

        for k in 0..min_len_usize {
            let char_idx = (s_bytes[k] - b'a') as usize;
            if freq[char_idx] == 0 {
                unique_count += 1;
            }
            freq[char_idx] += 1;
        }

        if unique_count <= max_letters {
            let sub_str = String::from_utf8_lossy(&s_bytes[0..min_len_usize]).to_string();

            let count = counts.entry(sub_str).or_insert(0);
            *count += 1;
            max_occurrences = max(max_occurrences, *count);
        }

        for i in 1..=(n - min_len_usize) {
            let prev_char_idx = (s_bytes[i-1] - b'a') as usize;
            freq[prev_char_idx] -= 1;
            if freq[prev_char_idx] == 0 {
                unique_count -= 1;
            }

            let new_char_idx = (s_bytes[i + min_len_usize - 1] - b'a') as usize;
            if freq[new_char_idx] == 0 {
                unique_count += 1;
            }
            freq[new_char_idx] += 1;

            if unique_count <= max_letters {
                let sub_str = String::from_utf8_lossy(&s_bytes[i..(i + min_len_usize)]).to_string();

                let count = counts.entry(sub_str).or_insert(0);
                *count += 1;
                max_occurrences = max(max_occurrences, *count);
            }
        }

        max_occurrences
    }
}