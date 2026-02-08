use std::collections::HashMap;

impl Solution {
    pub fn max_freq(s: String, max_letters: i32, min_size: i32, max_size: i32) -> i32 {
        let s = s.as_bytes();
        let max_letters = max_letters as usize;
        let min_size = min_size as usize;
        let max_size = max_size as usize;
        let mut max_occurrences = 0;
        let mut substr_counts = HashMap::new();

        for size in min_size..=max_size {
            let mut left = 0;
            let mut right = 0;
            let mut unique_chars = HashMap::new();

            while right < s.len() {
                *unique_chars.entry(s[right]).or_insert(0) += 1;
                right += 1;

                if right - left == size {
                    if unique_chars.len() <= max_letters {
                        let substr = &s[left..right];
                        let count = substr_counts.entry(substr).or_insert(0);
                        *count += 1;
                        if *count > max_occurrences {
                            max_occurrences = *count;
                        }
                    }

                    *unique_chars.get_mut(&s[left]).unwrap() -= 1;
                    if unique_chars[&s[left]] == 0 {
                        unique_chars.remove(&s[left]);
                    }
                    left += 1;
                }
            }
        }

        max_occurrences
    }
}