use std::collections::HashMap;

struct TopVotedCandidate {
    winners: Vec<i32>,
    times: Vec<i32>,
}

impl TopVotedCandidate {
    fn new(persons: Vec<i32>, times: Vec<i32>) -> Self {
        let mut winners = Vec::new();
        let mut votes = HashMap::new();
        let mut current_winner = -1;
        let mut max_votes = 0;

        for &person in &persons {
            let count = votes.entry(person).or_insert(0);
            *count += 1;

            if *count >= max_votes {
                max_votes = *count;
                current_winner = person;
            }
            winners.push(current_winner);
        }

        TopVotedCandidate {
            winners,
            times,
        }
    }

    fn q(&self, t: i32) -> i32 {
        let mut left = 0;
        let mut right = self.times.len() - 1;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if self.times[mid] <= t {
                ans = mid as i32;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        self.winners[ans as usize]
    }
}