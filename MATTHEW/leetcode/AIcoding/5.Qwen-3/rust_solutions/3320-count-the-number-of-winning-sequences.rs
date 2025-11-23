impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_winning_sequences(race: String) -> i32 {
        let mut dp = HashMap::new();
        let race_chars: Vec<char> = race.chars().collect();
        let n = race_chars.len();

        fn dfs(
            idx: usize,
            prev_char: char,
            race_chars: &[char],
            dp: &mut HashMap<(usize, char), i32>,
        ) -> i32 {
            if idx == race_chars.len() {
                return 1;
            }
            if let Some(&count) = dp.get(&(idx, prev_char)) {
                return count;
            }

            let mut total = 0;
            for c in ['a', 'b', 'c'] {
                if c != prev_char {
                    if race_chars[idx] == c {
                        total += dfs(idx + 1, c, race_chars, dp);
                    } else {
                        total += dfs(idx + 1, c, race_chars, dp);
                    }
                }
            }

            dp.insert((idx, prev_char), total);
            total
        }

        dfs(0, ' ', &race_chars, &mut dp)
    }
}
}