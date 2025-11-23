use std::collections::HashMap;

struct FindSumPairs {
    freq_map: HashMap<i32, i32>,
}

impl FindSumPairs {
    fn new(nums: Vec<i32>) -> Self {
        let mut freq_map = HashMap::new();
        for num in nums {
            *freq_map.entry(num).or_insert(0) += 1;
        }
        FindSumPairs {
            freq_map,
        }
    }

    fn add(&mut self, number: i32) {
        *self.freq_map.entry(number).or_insert(0) += 1;
    }

    fn count(&self, value: i32) -> i32 {
        let mut count = 0;
        for (&num, &freq) in &self.freq_map {
            let complement = value - num;
            if self.freq_map.contains_key(&complement) {
                let comp_freq = *self.freq_map.get(&complement).unwrap();

                if num == complement {
                    count += freq * (freq - 1) / 2;
                } else if num < complement { 
                    count += freq * comp_freq;
                }
            }
        }
        count
    }
}