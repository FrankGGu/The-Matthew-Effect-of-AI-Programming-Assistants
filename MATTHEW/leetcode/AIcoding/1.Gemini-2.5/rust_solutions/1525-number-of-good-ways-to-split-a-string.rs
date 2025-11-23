use std::collections::HashSet;

impl Solution {
    pub fn num_good_splits(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<u8> = s.bytes().collect();

        let mut left_distinct_counts = vec![0; n];
        let mut right_distinct_counts = vec![0; n];

        let mut seen_left = [false; 26];
        let mut current_distinct_left = 0;
        for i in 0..n {
            let char_idx = (chars[i] - b'a') as usize;
            if !seen_left[char_idx] {
                seen_left[char_idx] = true;
                current_distinct_left += 1;
            }
            left_distinct_counts[i] = current_distinct_left;
        }

        let mut seen_right = [false; 26];
        let mut current_distinct_right = 0;
        for i in (0..n).rev() {
            let char_idx = (chars[i] - b'a') as usize;
            if !seen_right[char_idx] {
                seen_right[char_idx] = true;
                current_distinct_right += 1;
            }
            right_distinct_counts[i] = current_distinct_right;
        }

        let mut good_ways = 0;
        for i in 0..n - 1 {
            if left_distinct_counts[i] == right_distinct_counts[i + 1] {
                good_ways += 1;
            }
        }

        good_ways
    }
}