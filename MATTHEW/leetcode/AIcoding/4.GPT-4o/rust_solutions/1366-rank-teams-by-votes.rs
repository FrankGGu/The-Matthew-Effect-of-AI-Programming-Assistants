use std::collections::HashMap;

pub fn rank_teams(votes: Vec<String>) -> String {
    let mut count = HashMap::new();
    let n = votes.len();

    for vote in votes {
        for (i, ch) in vote.chars().enumerate() {
            let entry = count.entry(ch).or_insert(vec![0; 26]);
            entry[i] += 1;
        }
    }

    let mut teams: Vec<_> = count.keys().collect();
    teams.sort_by(|a, b| {
        let (a_count, b_count) = (count[a], count[b]);
        for i in 0..26 {
            if a_count[i] != b_count[i] {
                return b_count[i].cmp(&a_count[i]);
            }
        }
        a.cmp(b)
    });

    teams.iter().collect()
}