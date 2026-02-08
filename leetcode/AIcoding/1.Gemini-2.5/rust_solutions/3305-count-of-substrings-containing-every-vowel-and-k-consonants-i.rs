struct Solution;

impl Solution {
    fn is_vowel(c: u8) -> bool {
        matches!(c as char, 'a' | 'e' | 'i' | 'o' | 'u')
    }

    fn get_vowel_idx(c: u8) -> usize {
        match c as char {
            'a' => 0,
            'e' => 1,
            'i' => 2,
            'o' => 3,
            'u' => 4,
            _ => unreachable!(),
        }
    }

    // Counts substrings that contain all 5 vowels and AT MOST `max_consonants` consonants.
    fn solve(s_bytes: &[u8], max_consonants: usize) -> i64 {
        let n = s_bytes.len();
        let mut ans = 0;

        let mut left_consonant_window = 0;
        let mut consonant_count_consonant_window = 0;

        let mut left_vowel_window = 0;
        let mut vowel_freq_vowel_window = [0; 5]; // Frequencies for s[left_vowel_window..right]
        let mut distinct_vowels_vowel_window = 0;

        for right in 0..n {
            let c_right = s_bytes[right];

            // --- Update for consonant constraint window [left_consonant_window..right] ---
            if !Self::is_vowel(c_right) {
                consonant_count_consonant_window += 1;
            }

            // Shrink left_consonant_window if consonant_count exceeds max_consonants
            while consonant_count_consonant_window > max_consonants {
                let c_left = s_bytes[left_consonant_window];
                if !Self::is_vowel(c_left) {
                    consonant_count_consonant_window -= 1;
                }
                left_consonant_window += 1;
            }

            // --- Update for vowel constraint window [left_vowel_window..right] ---
            if Self::is_vowel(c_right) {
                let v_idx = Self::get_vowel_idx(c_right);
                if vowel_freq_vowel_window[v_idx] == 0 {
                    distinct_vowels_vowel_window += 1;
                }
                vowel_freq_vowel_window[v_idx] += 1;
            }

            // Shrink left_vowel_window as much as possible while maintaining distinct_vowels_vowel_window == 5.
            // This `left_vowel_window` will point to the start of the shortest window ending at `right`
            // that contains all 5 vowels.
            while distinct_vowels_vowel_window == 5 {
                let c_left = s_bytes[left_vowel_window];
                if Self::is_vowel(c_left) {
                    let v_idx = Self::get_vowel_idx(c_left);
                    if vowel_freq_vowel_window[v_idx] == 1 {
                        break; // Cannot remove this vowel without losing distinctness
                    }
                    vowel_freq_vowel_window[v_idx] -= 1;
                }
                left_vowel_window += 1;
            }

            // At this point:
            // - `s[left_consonant_window..right]` has `consonant_count <= max_consonants`.
            // - If `distinct_vowels_vowel_window == 5`, then `s[left_vowel_window..right]` is the shortest window
            //   ending at `right` that contains all 5 vowels.

            // We need to count substrings `s[p..right]` such that:
            // a) `left_consonant_window <= p <= right` (satisfies consonant count)
            // b) `s[p..right]` contains all 5 vowels.

            // If `distinct_vowels_vowel_window == 5`, it means `s[left_vowel_window..right]` contains all 5 vowels.
            // Any `s[p..right]` where `p <= left_vowel_window` will also contain all 5 vowels.
            // So, valid 'p' values are in the range `[left_consonant_window, left_vowel_window]`.
            // The number of such 'p's is `left_vowel_window - left_consonant_window + 1`.
            // We take `max(0, ...)` to handle cases where `left_vowel_window < left_consonant_window`.
            if distinct_vowels_vowel_window == 5 {
                ans += (left_vowel_window as i64 - left_consonant_window as i64 + 1).max(0);
            }
        }
        ans
    }

    pub fn count_vowel_consonant_substrings(s: String, k: i32) -> i64 {
        let s_bytes = s.as_bytes();
        let k_usize = k as usize;

        let count_at_most_k = Self::solve(s_bytes, k_usize);
        let count_at_most_k_minus_1 = if k_usize == 0 {
            0
        } else {
            Self::solve(s_bytes, k_usize - 1)
        };

        count_at_most_k - count_at_most_k_minus_1
    }
}