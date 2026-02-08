use std::collections::HashMap;

impl Solution {
    pub fn rank_teams(votes: Vec<String>) -> String {
        let n = votes[0].len();
        let mut counts: HashMap<char, Vec<i32>> = HashMap::new();
        for &c in votes[0].as_bytes() {
            counts.insert(c as char, vec![0; n]);
        }

        for vote in &votes {
            for (i, &c) in vote.as_bytes().iter().enumerate() {
                counts.get_mut(&(c as char)).unwrap()[i] += 1;
            }
        }

        let mut teams: Vec<char> = votes[0].chars().collect();
        teams.sort_by(|&a, &b| {
            for i in 0..n {
                let count_a = counts.get(&a).unwrap()[i];
                let count_b = counts.get(&b).unwrap()[i];
                if count_a != count_b {
                    return count_b.cmp(&count_a);
                }
            }
            a.cmp(&b)
        });

        teams.into_iter().collect()
    }
}