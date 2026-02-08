use std::collections::HashMap;

impl Solution {
    pub fn min_stickers(stickers: Vec<String>, target: String) -> i32 {
        let mut dp = vec![-1; 1 << target.len()];
        dp[0] = 0;

        let sticker_counts: Vec<Vec<i32>> = stickers.iter().map(|s| {
            let mut count = vec![0; 26];
            for c in s.chars() {
                count[(c as u8 - b'a') as usize] += 1;
            }
            count
        }).collect();

        let target_count: Vec<i32> = {
            let mut count = vec![0; 26];
            for c in target.chars() {
                count[(c as u8 - b'a') as usize] += 1;
            }
            count
        };

        let target_mask = (0..target.len()).fold(0, |mask, i| mask | (1 << i));

        for mask in 0..(1 << target.len()) {
            if dp[mask] == -1 {
                continue;
            }
            for sticker in &sticker_counts {
                let mut new_mask = mask;
                let mut remaining = vec![0; 26];
                for i in 0..26 {
                    remaining[i] = target_count[i] - ((mask >> (i as usize)) & 1);
                }
                for i in 0..26 {
                    while sticker[i] > 0 && remaining[i] > 0 {
                        remaining[i] -= 1;
                        new_mask |= 1 << (i as usize);
                        sticker[i] -= 1;
                    }
                }
                dp[new_mask] = if dp[new_mask] == -1 {
                    dp[mask] + 1
                } else {
                    dp[new_mask].min(dp[mask] + 1)
                };
            }
        }

        if dp[target_mask] == -1 {
            -1
        } else {
            dp[target_mask]
        }
    }
}