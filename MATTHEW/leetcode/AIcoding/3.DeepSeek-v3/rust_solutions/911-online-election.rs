struct TopVotedCandidate {
    times: Vec<i32>,
    leaders: Vec<i32>,
}

impl TopVotedCandidate {
    fn new(persons: Vec<i32>, times: Vec<i32>) -> Self {
        let mut count = std::collections::HashMap::new();
        let mut max_vote = 0;
        let mut current_leader = -1;
        let mut leaders = Vec::with_capacity(persons.len());

        for &p in &persons {
            let entry = count.entry(p).or_insert(0);
            *entry += 1;
            if *entry >= max_vote {
                max_vote = *entry;
                current_leader = p;
            }
            leaders.push(current_leader);
        }

        TopVotedCandidate { times, leaders }
    }

    fn q(&self, t: i32) -> i32 {
        let idx = match self.times.binary_search(&t) {
            Ok(i) => i,
            Err(i) => i - 1,
        };
        self.leaders[idx]
    }
}