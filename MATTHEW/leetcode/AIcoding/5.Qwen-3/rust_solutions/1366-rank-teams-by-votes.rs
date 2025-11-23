impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn rank_teams(votes: Vec<Vec<char>>) -> Vec<char> {
        if votes.is_empty() {
            return vec![];
        }

        let mut count = HashMap::new();
        let len = votes[0].len();

        for vote in &votes {
            for (i, &c) in vote.iter().enumerate() {
                *count.entry(c).or_insert_with(|| vec![0; len])[*i] += 1;
            }
        }

        let mut chars: Vec<char> = count.keys().cloned().collect();
        chars.sort_by(|&a, &b| {
            for i in 0..len {
                if count[&a][i] != count[&b][i] {
                    return count[&b][i].cmp(&count[&a][i]);
                }
            }
            a.cmp(&b)
        });

        chars
    }
}
}