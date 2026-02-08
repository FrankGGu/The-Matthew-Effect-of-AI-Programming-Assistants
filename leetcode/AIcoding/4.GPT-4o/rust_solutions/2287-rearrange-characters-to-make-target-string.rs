impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        use std::collections::HashMap;

        let mut s_count = HashMap::new();
        let mut target_count = HashMap::new();

        for ch in s.chars() {
            *s_count.entry(ch).or_insert(0) += 1;
        }

        for ch in target.chars() {
            *target_count.entry(ch).or_insert(0) += 1;
        }

        let mut max_copies = i32::MAX;

        for (ch, &cnt) in target_count.iter() {
            if let Some(&available) = s_count.get(ch) {
                max_copies = max_copies.min(available / cnt);
            } else {
                return 0;
            }
        }

        max_copies
    }
}