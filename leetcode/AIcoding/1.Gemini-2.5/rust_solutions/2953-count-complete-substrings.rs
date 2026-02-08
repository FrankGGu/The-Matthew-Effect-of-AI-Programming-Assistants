use std::collections::BTreeMap;
use std::cmp::{min, max};

struct Solution;

impl Solution {
    pub fn count_complete_substrings(word: String, k: i32) -> i32 {
        let mut total_ans = 0;
        let word_chars: Vec<char> = word.chars().collect();
        let n = word_chars.len();

        let mut start = 0;
        for i in 0..n {
            if i > 0 && (word_chars[i] as i32 - word_chars[i-1] as i32).abs() > 2 {
                total_ans += Self::count_complete_in_segment(&word_chars[start..i], k);
                start = i;
            }
        }
        total_ans += Self::count_complete_in_segment(&word_chars[start..n], k);

        total_ans
    }

    // Counts complete substrings within a segment, using the "exactly m distinct characters" approach.
    fn count_complete_in_segment(segment: &[char], k_freq_diff: i32) -> i32 {
        let mut segment_ans = 0;
        // Iterate over possible number of distinct characters, `m`
        // `m` can be from 1 to 26 (alphabet size)
        for m in 1..=26 {
            segment_ans += Self::count_at_most_k_distinct_and_freq_ok(segment, m as i32, k_freq_diff);
            segment_ans -= Self::count_at_most_k_distinct_and_freq_ok(segment, (m - 1) as i32, k_freq_diff);
        }
        segment_ans
    }

    // Counts substrings with at most `k_distinct` characters AND `max_freq - min_freq <= k_freq_diff`.
    fn count_at_most_k_distinct_and_freq_ok(segment: &[char], k_distinct: i32, k_freq_diff: i32) -> i32 {
        if k_distinct == 0 {
            return 0; // Substrings with 0 distinct characters are empty, not counted.
        }

        let n = segment.len();
        let mut ans = 0;
        let mut left = 0;
        let mut char_counts = [0; 26]; // Frequency of each character (a-z) in current window
        let mut freq_of_freq = BTreeMap::new(); // Map: frequency -> count of characters with that frequency
        let mut distinct_char_count = 0;

        for right in 0..n {
            let current_char_idx = (segment[right] as u8 - b'a') as usize;

            // Update char_counts and freq_of_freq for the character at `right`
            let old_freq = char_counts[current_char_idx];
            if old_freq > 0 {
                // Decrease count for old frequency
                *freq_of_freq.get_mut(&old_freq).unwrap() -= 1;
                if freq_of_freq[&old_freq] == 0 {
                    freq_of_freq.remove(&old_freq);
                }
            } else {
                // New distinct character
                distinct_char_count += 1;
            }
            char_counts[current_char_idx] += 1;
            let new_freq = char_counts[current_char_idx];
            // Increase count for new frequency
            *freq_of_freq.entry(new_freq).or_insert(0) += 1;

            // Shrink window from `left` if conditions are violated
            while distinct_char_count > k_distinct ||
                  (distinct_char_count > 0 && (*freq_of_freq.keys().last().unwrap() - *freq_of_freq.keys().next().unwrap() > k_freq_diff)) {

                let left_char_idx = (segment[left] as u8 - b'a') as usize;

                // Update char_counts and freq_of_freq for the character at `left`
                let old_freq_left = char_counts[left_char_idx];
                *freq_of_freq.get_mut(&old_freq_left).unwrap() -= 1;
                if freq_of_freq[&old_freq_left] == 0 {
                    freq_of_freq.remove(&old_freq_left);
                }
                char_counts[left_char_idx] -= 1;
                let new_freq_left = char_counts[left_char_idx];
                if new_freq_left > 0 {
                    *freq_of_freq.entry(new_freq_left).or_insert(0) += 1;
                } else {
                    // Character is no longer in window
                    distinct_char_count -= 1;
                }
                left += 1;
            }

            // All substrings segment[left..right+1], segment[left+1..right+1], ..., segment[right..right+1]
            // now satisfy distinct_char_count <= k_distinct AND freq_diff <= k_freq_diff
            ans += (right - left + 1) as i32;
        }
        ans
    }
}