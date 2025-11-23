impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn num_shortest_supersequences(target: String, words: Vec<String>) -> i32 {
        let mut word_map = HashMap::new();
        for word in &words {
            word_map.entry(word).or_insert(0);
            *word_map.get_mut(word).unwrap() += 1;
        }

        let mut dp = vec![0; target.len()];
        let mut last_pos = vec![0; 26];

        for i in 0..target.len() {
            let c = target.as_bytes()[i] - b'a';
            for j in 0..26 {
                if last_pos[j] > 0 {
                    dp[i] = dp[i].max(dp[last_pos[j] as usize - 1]);
                }
            }
            dp[i] += 1;
            last_pos[c as usize] = i as i32 + 1;
        }

        let max_len = dp.iter().max().copied().unwrap_or(0);

        let mut result = 0;
        for word in words {
            let mut pos = 0;
            let mut count = 0;
            for c in word.bytes() {
                while pos < target.len() && target.as_bytes()[pos] != c {
                    pos += 1;
                }
                if pos < target.len() {
                    count += 1;
                    pos += 1;
                } else {
                    break;
                }
            }
            if count == word.len() {
                result += word_map.get(&word).copied().unwrap_or(0);
            }
        }

        result
    }
}
}