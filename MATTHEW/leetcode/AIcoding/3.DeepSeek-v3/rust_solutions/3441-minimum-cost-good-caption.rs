use std::collections::HashMap;

impl Solution {
    pub fn minimum_cost_sentence(words: Vec<String>, groups: Vec<i32>) -> Vec<String> {
        let n = words.len();
        let mut dp = vec![(i32::MAX, 0); n + 1];
        dp[0] = (0, -1);

        for i in 1..=n {
            for j in (0..i).rev() {
                if j > 0 && groups[j - 1] == groups[i - 1] {
                    continue;
                }
                if dp[j].0 + 1 < dp[i].0 {
                    dp[i] = (dp[j].0 + 1, j as i32);
                }
            }
        }

        let mut res = Vec::new();
        let mut i = n;
        while i > 0 {
            let prev = dp[i].1 as usize;
            res.push(words[prev..i].join(" "));
            i = prev;
        }

        res.reverse();
        res
    }
}