use std::collections::HashMap;

impl Solution {
    pub fn min_stickers(stickers: Vec<String>, target: String) -> i32 {
        let n = target.len();
        let mut dp = vec![-1; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == -1 {
                continue;
            }

            for sticker in &stickers {
                let mut new_mask = mask;
                let mut sticker_chars: HashMap<char, i32> = HashMap::new();
                for c in sticker.chars() {
                    *sticker_chars.entry(c).or_insert(0) += 1;
                }

                for i in 0..n {
                    if (mask & (1 << i)) == 0 {
                        let target_char = target.chars().nth(i).unwrap();
                        if sticker_chars.contains_key(&target_char) && sticker_chars[&target_char] > 0 {
                            *sticker_chars.entry(target_char).or_insert(0) -= 1;
                            new_mask |= 1 << i;
                        }
                    }
                }

                if dp[new_mask] == -1 || dp[new_mask] > dp[mask] + 1 {
                    dp[new_mask] = dp[mask] + 1;
                }
            }
        }

        dp[(1 << n) - 1]
    }
}