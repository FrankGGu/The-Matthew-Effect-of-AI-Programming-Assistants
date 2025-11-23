use std::collections::HashMap;

impl Solution {
    pub fn longest_special_substring(s: String) -> i32 {
        let mut char_blocks: HashMap<char, Vec<usize>> = HashMap::new();
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        if n < 3 {
            return -1;
        }

        let mut i = 0;
        while i < n {
            let current_char = chars[i];
            let mut j = i;
            while j < n && chars[j] == current_char {
                j += 1;
            }
            let length = j - i;
            char_blocks.entry(current_char).or_default().push(length);
            i = j;
        }

        let mut max_overall_k = 0;

        for (_, lengths) in char_blocks.iter_mut() {
            lengths.sort_unstable_by(|a, b| b.cmp(a)); // Sort in descending order

            let mut ans_for_ch = 0;

            // Case 1: At least three distinct blocks of length >= k
            // If we have blocks L1, L2, L3 (L1 >= L2 >= L3), then a substring of length L3
            // can be formed from each of these three blocks.
            if lengths.len() >= 3 {
                ans_for_ch = ans_for_ch.max(lengths[2]);
            }

            // Case 2: Two blocks of length >= k, and one block of length k from one of the two.
            // Let the two longest blocks be L1 and L2 (L1 >= L2).
            // We want to find the maximum k such that (L1 - k + 1) + (L2 - k + 1) >= 3.
            // This simplifies to L1 + L2 + 2 - 2k >= 3, or L1 + L2 - 1 >= 2k.
            // So, k <= (L1 + L2 - 1) / 2.
            if lengths.len() >= 2 {
                let l1 = lengths[0];
                let l2 = lengths[1];
                let k_candidate = (l1 + l2 - 1) / 2;
                ans_for_ch = ans_for_ch.max(k_candidate);
            }

            // Case 3: One block of length >= k, and two blocks of length k from it.
            // Let the longest block be L1.
            // We want to find the maximum k such that L1 - k + 1 >= 3.
            // This simplifies to L1 - k >= 2, or k <= L1 - 2.
            if lengths.len() >= 1 {
                let l1 = lengths[0];
                let k_candidate = l1.saturating_sub(2); // k must be non-negative
                ans_for_ch = ans_for_ch.max(k_candidate);
            }

            max_overall_k = max_overall_k.max(ans_for_ch);
        }

        if max_overall_k == 0 {
            -1
        } else {
            max_overall_k as i32
        }
    }
}