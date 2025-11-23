impl Solution {
    pub fn min_stickers(stickers: Vec<String>, target: String) -> i32 {
        let target_chars: Vec<char> = target.chars().collect();
        let n = target_chars.len();
        let total_states = 1 << n;
        let mut dp = vec![-1; total_states];
        dp[0] = 0;

        for state in 0..total_states {
            if dp[state] == -1 {
                continue;
            }

            for sticker in &stickers {
                let mut next_state = state;
                let mut sticker_chars = sticker.chars().collect::<Vec<char>>();

                for &c in &target_chars {
                    if (next_state & (1 << target_chars.iter().position(|&x| x == c).unwrap_or(n)) == 0 {
                        if let Some(pos) = sticker_chars.iter().position(|&x| x == c) {
                            sticker_chars.remove(pos);
                            next_state |= 1 << target_chars.iter().position(|&x| x == c).unwrap();
                        }
                    }
                }

                if dp[next_state] == -1 || dp[next_state] > dp[state] + 1 {
                    dp[next_state] = dp[state] + 1;
                }
            }
        }

        dp[total_states - 1]
    }
}