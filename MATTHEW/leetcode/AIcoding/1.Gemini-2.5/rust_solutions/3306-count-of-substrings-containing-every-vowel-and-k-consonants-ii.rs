struct Solution;

impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i64 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();

        #[inline]
        fn is_vowel(c: char) -> bool {
            c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
        }

        #[inline]
        fn get_vowel_idx(c: char) -> usize {
            match c {
                'a' => 0,
                'e' => 1,
                'i' => 2,
                'o' => 3,
                'u' => 4,
                _ => unreachable!(),
            }
        }

        const ALL_VOWELS_MASK: u8 = 0b11111;

        fn count_at_most_k_consonants_and_all_vowels(
            chars: &[char],
            max_consonants: i32,
        ) -> i64 {
            let n = chars.len();
            let mut total_count = 0;

            let mut left_c = 0; // Left pointer for consonant constraint
            let mut consonant_count = 0;

            let mut left_v = 0; // Left pointer for all-vowels constraint
            let mut vowel_counts_v = [0; 5]; // Vowel counts for window [left_v, right]
            let mut vowel_mask_v = 0; // Vowel mask for window [left_v, right]

            for right in 0..n {
                let c_right = chars[right];

                // Add char_right to the consonant window (implicitly [left_c, right])
                // and to the vowel window [left_v, right]
                if is_vowel(c_right) {
                    let idx = get_vowel_idx(c_right);
                    vowel_counts_v[idx] += 1;
                    if vowel_counts_v[idx] == 1 {
                        vowel_mask_v |= (1 << idx);
                    }
                } else {
                    consonant_count += 1;
                }

                // Adjust left_c to satisfy consonant_count <= max_consonants
                while consonant_count > max_consonants {
                    let c_lc = chars[left_c];
                    if !is_vowel(c_lc) {
                        consonant_count -= 1;
                    }
                    left_c += 1;
                }

                // Adjust left_v to be the leftmost point where s[left_v..right] has all vowels.
                // This means vowel_mask_v must be ALL_VOWELS_MASK, and if we remove chars[left_v],
                // it would break the ALL_VOWELS_MASK condition (i.e., vowel_counts_v[idx] == 1).
                while vowel_mask_v == ALL_VOWELS_MASK {
                    let c_lv = chars[left_v];
                    if is_vowel(c_lv) {
                        let idx = get_vowel_idx(c_lv);
                        if vowel_counts_v[idx] == 1 {
                            // Removing this would break the all-vowels mask for this specific vowel
                            break;
                        }
                        vowel_counts_v[idx] -= 1;
                    }
                    left_v += 1;
                }

                // Now, we count valid substrings s[l..right] for the current `right`.
                // A substring s[l..right] is valid if:
                // 1. `l >= left_c` (consonant constraint is met for s[left_c..right], so also for s[l..right] where l >= left_c)
                // 2. `l <= left_v - 1` (vowel constraint: `left_v` is the first index such that `s[left_v..right]` does NOT have all vowels.
                //    So, any `l` in `[0, left_v - 1]` *could* be a valid start for vowels.)
                // Combining these, `l` must be in `[left_c, left_v - 1]`.
                // The number of such `l` is `(left_v - 1) - left_c + 1 = left_v - left_c`.
                // This must be non-negative.
                total_count += (left_v - left_c).max(0);
            }
            total_count
        }

        // The answer is (count of substrings with at most K consonants and all vowels)
        // minus (count of substrings with at most K-1 consonants and all vowels).
        // This is a standard inclusion-exclusion principle for "exactly K" problems.
        let result_at_most_k = count_at_most_k_consonants_and_all_vowels(&chars, k);
        let result_at_most_k_minus_1 =
            count_at_most_k_consonants_and_all_vowels(&chars, k - 1);

        result_at_most_k - result_at_most_k_minus_1
    }
}