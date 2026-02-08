use std::cmp::{max, min};

impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut first = vec![n; 26];
        let mut last = vec![0; 26];

        for i in 0..n {
            let char_idx = (s_bytes[i] - b'a') as usize;
            if first[char_idx] == n {
                first[char_idx] = i;
            }
            last[char_idx] = i;
        }

        let mut all_valid_intervals: Vec<(usize, usize)> = Vec::new();

        for i in 0..n {
            let left_char_idx = (s_bytes[i] - b'a') as usize;

            // If s[i] is not the first occurrence of its character,
            // then any valid substring starting at 'i' would have to include
            // the first occurrence of s[i], which is before 'i'.
            // So 'i' cannot be the leftmost boundary of a minimal valid substring.
            // We only consider 'i' if it's the first occurrence of s[i].
            if first[left_char_idx] < i {
                continue;
            }

            // Now, i is the first occurrence of s[i]. This is a potential start.
            let mut current_max_end = last[left_char_idx];
            let mut is_valid_start = true;

            // Expand the end boundary to include all characters' full ranges.
            // Also, check if any character forces the start boundary to be less than i.
            let mut k = i;
            while k <= current_max_end {
                let char_k_idx = (s_bytes[k] - b'a') as usize;

                // If any character s[k] within the current segment [i, current_max_end]
                // has its first occurrence before i, then [i, current_max_end] is not a valid segment.
                if first[char_k_idx] < i {
                    is_valid_start = false;
                    break;
                }

                // Expand current_max_end to ensure it covers the last occurrence of s[k].
                current_max_end = max(current_max_end, last[char_k_idx]);
                k += 1;
            }

            if is_valid_start {
                all_valid_intervals.push((i, current_max_end));
            }
        }

        // Sort intervals by their end points. If end points are equal, sort by start points (or length).
        // Sorting by end then start ensures we pick the shortest interval first among those ending at the same point.
        // This is crucial for maximizing the number of non-overlapping intervals.
        all_valid_intervals.sort_unstable_by(|a, b| {
            if a.1 != b.1 {
                a.1.cmp(&b.1)
            } else {
                a.0.cmp(&b.0)
            }
        });

        let mut result_substrings: Vec<String> = Vec::new();
        let mut prev_end = -1; // Use -1 to indicate no previous interval.

        for &(start, end) in &all_valid_intervals {
            if start as isize > prev_end {
                result_substrings.push(s[start..=end].to_string());
                prev_end = end as isize;
            }
        }

        result_substrings
    }
}