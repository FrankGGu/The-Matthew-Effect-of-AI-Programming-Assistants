use std::collections::HashMap;

struct FrequencyTracker {
    map: HashMap<i32, usize>,
    prefix_sum: Vec<usize>,
}

impl FrequencyTracker {
    fn new() -> Self {
        FrequencyTracker {
            map: HashMap::new(),
            prefix_sum: vec![0; 100001],
        }
    }

    fn add(&mut self, number: i32) {
        let count = self.map.entry(number).or_insert(0);
        if *count > 0 {
            self.prefix_sum[*count] -= 1;
        }
        *count += 1;
        self.prefix_sum[*count] += 1;
    }

    fn delete_one(&mut self, number: i32) {
        if let Some(count) = self.map.get_mut(&number) {
            if *count > 0 {
                self.prefix_sum[*count] -= 1;
                *count -= 1;
                self.prefix_sum[*count] += 1;
            }
        }
    }

    fn count(&self, number: i32) -> i32 {
        *self.map.get(&number).unwrap_or(&0) as i32
    }

    fn range_freq_query(&self, left: i32, right: i32, freq: i32) -> bool {
        let left_freq = self.prefix_sum[freq as usize];
        let right_freq = if right as usize + 1 < self.prefix_sum.len() {
            self.prefix_sum[freq as usize] - self.prefix_sum[freq as usize + 1]
        } else {
            left_freq
        };
        left_freq > 0 && right_freq > 0
    }
}