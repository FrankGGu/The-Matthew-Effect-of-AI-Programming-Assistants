use std::cmp::Ordering;

#[derive(Debug)]
struct Team {
    name: char,
    ranks: Vec<usize>,
}

impl Team {
    fn new(name: char, size: usize) -> Self {
        Team {
            name,
            ranks: vec![0; size],
        }
    }
}

impl PartialEq for Team {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name
    }
}

impl Eq for Team {}

impl PartialOrd for Team {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Team {
    fn cmp(&self, other: &Self) -> Ordering {
        for (a, b) in self.ranks.iter().zip(other.ranks.iter()) {
            if a != b {
                return b.cmp(a);
            }
        }
        self.name.cmp(&other.name)
    }
}

impl Solution {
    pub fn rank_teams(votes: Vec<String>) -> String {
        if votes.is_empty() {
            return String::new();
        }
        let vote_len = votes[0].len();
        let mut teams = vec![];
        let mut name_set = std::collections::HashSet::new();

        for vote in &votes {
            for (i, c) in vote.chars().enumerate() {
                if !name_set.contains(&c) {
                    name_set.insert(c);
                    teams.push(Team::new(c, vote_len));
                }
            }
        }

        for vote in &votes {
            for (i, c) in vote.chars().enumerate() {
                if let Some(team) = teams.iter_mut().find(|t| t.name == c) {
                    team.ranks[i] += 1;
                }
            }
        }

        teams.sort();

        teams.iter().map(|t| t.name).collect()
    }
}