use std::collections::HashMap;

impl Solution {
    pub fn max_frequency_elements(nums: Vec<i32>) -> i32 {
        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *freq_map.entry(num).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        for &freq in freq_map.values() {
            max_freq = max_freq.max(freq);
        }

        let mut count = 0;
        for &freq in freq_map.values() {
            if freq == max_freq {
                count += freq;
            }
        }

        count
    }
}