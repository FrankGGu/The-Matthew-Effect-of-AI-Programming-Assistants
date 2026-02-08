use std::collections::HashMap;

impl Solution {
    pub fn count_substrings(s: String) -> i64 {
        let target = "leetcode";
        let mut target_counts: HashMap<char, i32> = HashMap::new();
        for c in target.chars() {
            *target_counts.entry(c).or_insert(0) += 1;
        }

        let mut current_counts: HashMap<char, i32> = HashMap::new();
        let mut satisfied_distinct_chars = 0; // Number of distinct target characters whose counts are met
        let mut ans: i64 = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();
        let mut left = 0;

        for right in 0..n {
            let r_char = s_chars[right];

            let current_r_char_count = current_counts.entry(r_char).or_insert(0);

            if let Some(&required_count) = target_counts.get(&r_char) {
                // Check if this character's requirement is now satisfied
                if *current_r_char_count < required_count && (*current_r_char_count + 1) >= required_count {
                    satisfied_distinct_chars += 1;
                }
            }
            *current_r_char_count += 1;

            // Shrink window from left if all requirements are met
            while satisfied_distinct_chars == target_counts.len() {
                // If s[left..right] is a valid window, then all substrings s[k..right]
                // for 0 <= k <= left are also valid.
                // The number of such starting positions (k) is `left + 1`.
                ans += (left + 1) as i64;

                let l_char = s_chars[left];
                let current_l_char_count = current_counts.get_mut(&l_char).unwrap(); // Must exist in current_counts

                if let Some(&required_count) = target_counts.get(&l_char) {
                    // Check if this character's requirement is no longer satisfied
                    if *current_l_char_count >= required_count && (*current_l_char_count - 1) < required_count {
                        satisfied_distinct_chars -= 1;
                    }
                }
                *current_l_char_count -= 1;
                left += 1;
            }
        }

        ans
    }
}