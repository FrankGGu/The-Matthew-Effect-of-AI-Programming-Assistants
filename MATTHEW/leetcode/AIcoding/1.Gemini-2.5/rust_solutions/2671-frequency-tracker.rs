use std::collections::HashMap;

struct FrequencyTracker {
    num_counts: HashMap<i32, i32>,
    freq_counts: HashMap<i32, i32>,
}

impl FrequencyTracker {
    fn new() -> Self {
        FrequencyTracker {
            num_counts: HashMap::new(),
            freq_counts: HashMap::new(),
        }
    }

    fn add(&mut self, number: i32) {
        let old_freq = *self.num_counts.get(&number).unwrap_or(&0);

        if old_freq > 0 {
            *self.freq_counts.get_mut(&old_freq).unwrap() -= 1;
            if *self.freq_counts.get(&old_freq).unwrap() == 0 {
                self.freq_counts.remove(&old_freq);
            }
        }

        let new_freq = old_freq + 1;
        self.num_counts.insert(number, new_freq);
        *self.freq_counts.entry(new_freq).or_insert(0) += 1;
    }

    fn delete(&mut self, number: i32) {
        let old_freq = *self.num_counts.get(&number).unwrap_or(&0);

        if old_freq == 0 {
            return;
        }

        *self.freq_counts.get_mut(&old_freq).unwrap() -= 1;
        if *self.freq_counts.get(&old_freq).unwrap() == 0 {
            self.freq_counts.remove(&old_freq);
        }

        let new_freq = old_freq - 1;

        if new_freq == 0 {
            self.num_counts.remove(&number);
        } else {
            self.num_counts.insert(number, new_freq);
            *self.freq_counts.entry(new_freq).or_insert(0) += 1;
        }
    }

    fn has_frequency(&self, frequency: i32) -> bool {
        *self.freq_counts.get(&frequency).unwrap_or(&0) > 0
    }
}