use std::collections::HashMap;

struct FrequencyTracker {
    count: HashMap<i32, i32>,
    freq: HashMap<i32, i32>,
}

impl FrequencyTracker {
    fn new() -> Self {
        FrequencyTracker {
            count: HashMap::new(),
            freq: HashMap::new(),
        }
    }

    fn add(&mut self, number: i32) {
        let prev_count = self.count.entry(number).or_insert(0);
        if *prev_count > 0 {
            *self.freq.get_mut(&(*prev_count)).unwrap() -= 1;
        }
        *prev_count += 1;
        let new_count = *prev_count;
        *self.freq.entry(new_count).or_insert(0) += 1;
    }

    fn delete(&mut self, number: i32) {
        if let Some(prev_count) = self.count.get_mut(&number) {
            if *prev_count > 0 {
                *self.freq.get_mut(&(*prev_count)).unwrap() -= 1;
                *prev_count -= 1;
                if *prev_count > 0 {
                    *self.freq.entry(*prev_count).or_insert(0) += 1;
                }
            }
        }
    }

    fn has_frequency(&self, frequency: i32) -> bool {
        self.freq.get(&frequency).map_or(false, |&count| count > 0)
    }
}