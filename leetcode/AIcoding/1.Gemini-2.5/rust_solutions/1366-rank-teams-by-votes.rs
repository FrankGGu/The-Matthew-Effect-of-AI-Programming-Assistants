use std::collections::HashMap;
use std::cmp::Ordering;

impl Solution {
    pub fn rank_teams(votes: Vec<String>) -> String {
        if votes.is_empty() {
            return String::new();
        }

        let num_teams = votes[0].len();
        let mut team_counts: HashMap<char, Vec<i32>> = HashMap::new();

        // Initialize team_counts for all teams present in the first vote
        // The first vote string contains all participating teams.
        for team_char in votes[0].chars() {
            team_counts.insert(team_char, vec![0; num_teams]);
        }

        // Populate vote counts for each team at each position
        for vote_str in votes {
            for (pos, team_char) in vote_str.chars().enumerate() {
                // We can unwrap here because all teams are guaranteed to be initialized
                // from the first vote string.
                team_counts.get_mut(&team_char).unwrap()[pos] += 1;
            }
        }

        // Get the list of teams to sort (from the first vote string)
        let mut teams: Vec<char> = votes[0].chars().collect();

        // Sort teams based on custom criteria
        teams.sort_by(|&a, &b| {
            let a_counts = team_counts.get(&a).unwrap();
            let b_counts = team_counts.get(&b).unwrap();

            // Compare vote counts at each position
            for i in 0..num_teams {
                let cmp_result = a_counts[i].cmp(&b_counts[i]);
                if cmp_result != Ordering::Equal {
                    // If a team has more votes at a given position, it ranks higher.
                    // `sort_by` expects `Ordering::Less` if `a` should come before `b`.
                    // If `a_counts[i]` is greater than `b_counts[i]`, `a` is better,
                    // so `a` should come before `b`. `cmp_result` would be `Ordering::Greater`.
                    // We need to reverse it to `Ordering::Less`.
                    return cmp_result.reverse();
                }
            }
            // If all vote counts are tied, sort alphabetically (ascending)
            a.cmp(&b)
        });

        teams.into_iter().collect()
    }
}