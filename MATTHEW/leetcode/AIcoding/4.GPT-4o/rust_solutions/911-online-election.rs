use std::collections::HashMap;

struct TopVotedCandidate {
    times: Vec<i32>,
    leaders: Vec<i32>,
}

impl TopVotedCandidate {
    fn new(persons: Vec<i32>, times: Vec<i32>) -> Self {
        let mut count = HashMap::new();
        let mut max_count = 0;
        let mut leader = -1;
        let mut leaders = Vec::new();

        for (i, &person) in persons.iter().enumerate() {
            *count.entry(person).or_insert(0) += 1;
            if count[&person] >= max_count {
                max_count = count[&person];
                leader = person;
            }
            leaders.push(leader);
        }

        TopVotedCandidate { times, leaders }
    }

    fn q(&self, t: i32) -> i32 {
        let mut left = 0;
        let mut right = self.times.len() as i32 - 1;

        while left < right {
            let mid = (left + right + 1) / 2;
            if self.times[mid] <= t {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        self.leaders[left as usize]
    }
}