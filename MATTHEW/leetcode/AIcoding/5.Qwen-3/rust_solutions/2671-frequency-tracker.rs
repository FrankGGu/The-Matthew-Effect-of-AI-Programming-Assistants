impl Solution {

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
        let prev_count = *self.count.get(&number).unwrap_or(&0);
        if prev_count > 0 {
            *self.freq.entry(prev_count).or_insert(0) -= 1;
            if *self.freq.get(&prev_count).unwrap() == 0 {
                self.freq.remove(&prev_count);
            }
        }
        *self.count.entry(number).or_insert(0) += 1;
        let new_count = *self.count.get(&number).unwrap();
        *self.freq.entry(new_count).or_insert(0) += 1;
    }

    fn delete(&mut self, number: i32) {
        let prev_count = *self.count.get(&number).unwrap_or(&0);
        if prev_count > 0 {
            *self.freq.entry(prev_count).or_insert(0) -= 1;
            if *self.freq.get(&prev_count).unwrap() == 0 {
                self.freq.remove(&prev_count);
            }
            *self.count.entry(number).or_insert(0) -= 1;
            if *self.count.get(&number).unwrap() == 0 {
                self.count.remove(&number);
            }
            let new_count = *self.count.get(&number).unwrap_or(&0);
            if new_count > 0 {
                *self.freq.entry(new_count).or_insert(0) += 1;
            }
        }
    }

    fn has_frequency(&self, frequency: i32) -> bool {
        self.freq.contains_key(&frequency)
    }
}
}