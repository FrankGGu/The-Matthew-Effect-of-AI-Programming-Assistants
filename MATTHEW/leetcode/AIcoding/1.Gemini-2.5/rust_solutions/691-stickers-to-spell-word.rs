use std::cmp::min;

impl Solution {
    pub fn min_stickers(stickers: Vec<String>, target: String) -> i32 {
        let n = target.len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        let mut processed_stickers: Vec<[i32; 26]> = Vec::new();
        for sticker_str in stickers {
            let mut counts = [0; 26];
            for c in sticker_str.chars() {
                counts[c as usize - 'a' as usize] += 1;
            }
            processed_stickers.push(counts);
        }

        let target_chars: Vec<char> = target.chars().collect();

        for mask in 0..(1 << n) {
            if dp[mask] == i32::MAX {
                continue;
            }

            // Find the first character in target that is not yet covered by the current mask
            let mut first_uncovered_char_idx = -1;
            for i in 0..n {
                if (mask >> i) & 1 == 0 {
                    first_uncovered_char_idx = i as i32;
                    break;
                }
            }

            // If all characters are covered, we are done with this mask
            if first_uncovered_char_idx == -1 {
                continue;
            }

            // Optimization: Only consider stickers that contain the first uncovered character
            let first_uncovered_target_char_val = target_chars[first_uncovered_char_idx as usize] as usize - 'a' as usize;

            for sticker_counts in &processed_stickers {
                // If the sticker doesn't have the first needed character, it's not optimal to use it now
                if sticker_counts[first_uncovered_target_char_val] == 0 {
                    continue;
                }

                let mut current_sticker_counts = *sticker_counts; // Copy the counts for mutable use
                let mut next_mask = mask;

                // Apply the sticker to cover as many *uncovered* characters as possible
                for i in 0..n {
                    if (next_mask >> i) & 1 == 0 { // If target[i] is not yet covered
                        let char_val = target_chars[i] as usize - 'a' as usize;
                        if current_sticker_counts[char_val] > 0 {
                            current_sticker_counts[char_val] -= 1;
                            next_mask |= (1 << i);
                        }
                    }
                }

                // If the sticker actually covered new characters, update dp
                if next_mask != mask {
                    dp[next_mask] = min(dp[next_mask], dp[mask] + 1);
                }
            }
        }

        dp[(1 << n) - 1]
    }
}