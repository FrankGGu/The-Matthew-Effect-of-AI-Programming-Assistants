impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_seconds(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        let mut char_positions = HashMap::new();

        for (i, &c) -> _ in s_chars.iter().enumerate() {
            char_positions.entry(c).or_insert(Vec::new()).push(i);
        }

        let mut max_gap = 0;

        for positions in char_positions.values() {
            let m = positions.len();
            let mut max_gap_for_char = 0;

            for i in 0..m {
                let prev = positions[i];
                let next = positions[(i + 1) % m];

                let gap = if next > prev {
                    next - prev
                } else {
                    n - prev + next
                };

                max_gap_for_char = max_gap_for_char.max(gap);
            }

            max_gap = max_gap.max(max_gap_for_char);
        }

        (n - max_gap) as i32
    }
}
}