use std::collections::HashMap;

struct FrequencyTracker {
    num_to_freq: HashMap<i32, i32>,
    freq_to_count: HashMap<i32, i32>,
}

impl FrequencyTracker {
    fn new() -> Self {
        FrequencyTracker {
            num_to_freq: HashMap::new(),
            freq_to_count: HashMap::new(),
        }
    }

    fn add(&mut self, number: i32) {
        let old_freq = self.num_to_freq.get(&number).cloned().unwrap_or(0);
        let new_freq = old_freq + 1;

        self.num_to_freq.insert(number, new_freq);

        if old_freq > 0 {
            *self.freq_to_count.entry(old_freq).or_default() -= 1;
        }
        *self.freq_to_count.entry(new_freq).or_default() += 1;
    }

    fn delete_one(&mut self, number: i32) {
        if let Some(old_freq) = self.num_to_freq.get_mut(&number) {
            if *old_freq > 0 {
                let new_freq = *old_freq - 1;

                *self.freq_to_count.entry(*old_freq).or_default() -= 1;
                if new_freq > 0 {
                    *self.freq_to_count.entry(new_freq).or_default() += 1;
                    self.num_to_freq.insert(number, new_freq);
                } else {
                    self.num_to_freq.remove(&number);
                }
            }
        }
    }

    fn has_frequency(&self, frequency: i32) -> bool {
        self.freq_to_count.get(&frequency).map_or(false, |&count| count > 0)
    }
}