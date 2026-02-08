use std::collections::HashMap;

struct TopVotedCandidate {
    leading_candidates_at_time: Vec<(i32, i32)>,
}

impl TopVotedCandidate {
    fn new(persons: Vec<i32>, times: Vec<i32>) -> Self {
        let n = persons.len();
        let mut vote_counts: HashMap<i32, i32> = HashMap::new();
        let mut leading_candidates_at_time: Vec<(i32, i32)> = Vec::with_capacity(n);

        let mut current_leader = -1;
        let mut max_votes = -1;

        for i in 0..n {
            let person = persons[i];
            let time = times[i];

            *vote_counts.entry(person).or_insert(0) += 1;
            let person_votes = *vote_counts.get(&person).unwrap();

            if person_votes >= max_votes {
                max_votes = person_votes;
                current_leader = person;
            }

            leading_candidates_at_time.push((time, current_leader));
        }

        TopVotedCandidate {
            leading_candidates_at_time,
        }
    }

    fn q(&self, t: i32) -> i32 {
        match self.leading_candidates_at_time.binary_search_by_key(&t, |&(time, _)| time) {
            Ok(idx) => {
                self.leading_candidates_at_time[idx].1
            },
            Err(idx) => {
                self.leading_candidates_at_time[idx - 1].1
            }
        }
    }
}