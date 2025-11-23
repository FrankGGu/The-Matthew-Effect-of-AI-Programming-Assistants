impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_bouquets_to_buy(arr: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        let mut max_freq = 0;
        let mut max_freq_count = 0;

        for &num in &arr {
            let freq = count.entry(num).or_insert(0);
            *freq += 1;
            if *freq > max_freq {
                max_freq = *freq;
                max_freq_count = 1;
            } else if *freq == max_freq {
                max_freq_count += 1;
            }
        }

        if max_freq_count > k as usize {
            return -1;
        }

        let mut result = 0;
        for &num in &arr {
            let freq = count.get(&num).unwrap();
            result += (freq - 1) / k;
        }

        result
    }
}
}