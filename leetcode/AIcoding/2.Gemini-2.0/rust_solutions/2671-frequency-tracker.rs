use std::collections::HashMap;

struct FrequencyTracker {
    counts: HashMap<i32, i32>,
    freqs: HashMap<i32, i32>,
}

impl FrequencyTracker {
    fn new() -> Self {
        FrequencyTracker {
            counts: HashMap::new(),
            freqs: HashMap::new(),
        }
    }

    fn add(&mut self, number: i32) {
        let count = self.counts.entry(number).or_insert(0);
        let old_freq = *count;
        *count += 1;
        let new_freq = *count;

        if old_freq > 0 {
            let old_freq_count = self.freqs.entry(old_freq).or_insert(0);
            *old_freq_count -= 1;
            if *old_freq_count == 0 {
                self.freqs.remove(&old_freq);
            }
        }

        let new_freq_count = self.freqs.entry(new_freq).or_insert(0);
        *new_freq_count += 1;
    }

    fn delete_one(&mut self, number: i32) {
        if let Some(count) = self.counts.get_mut(&number) {
            if *count > 0 {
                let old_freq = *count;
                *count -= 1;
                let new_freq = *count;

                let old_freq_count = self.freqs.entry(old_freq).or_insert(0);
                *old_freq_count -= 1;
                if *old_freq_count == 0 {
                    self.freqs.remove(&old_freq);
                }

                if new_freq > 0 {
                    let new_freq_count = self.freqs.entry(new_freq).or_insert(0);
                    *new_freq_count += 1;
                }

                if *count == 0 {
                    self.counts.remove(&number);
                }
            }
        }
    }

    fn has_frequency(&self, frequency: i32) -> bool {
        self.freqs.contains_key(&frequency)
    }
}