use std::collections::HashMap;

impl Solution {
    pub fn max_freq(s: String, max_letters: i32, min_size: i32, max_size: i32) -> i32 {
        let mut freq_map: HashMap<String, i32> = HashMap::new();
        let n = s.len();
        let min_size = min_size as usize;
        let s_bytes = s.as_bytes();

        for i in 0..=n - min_size {
            let sub = String::from_utf8_lossy(&s_bytes[i..i + min_size]).to_string();
            let mut char_count: HashMap<char, i32> = HashMap::new();
            for c in sub.chars() {
                *char_count.entry(c).or_insert(0) += 1;
            }

            if char_count.len() as i32 <= max_letters {
                *freq_map.entry(sub).or_insert(0) += 1;
            }
        }

        let mut max_freq_val = 0;
        for (_, freq) in freq_map {
            max_freq_val = max_freq_val.max(freq);
        }

        max_freq_val
    }
}