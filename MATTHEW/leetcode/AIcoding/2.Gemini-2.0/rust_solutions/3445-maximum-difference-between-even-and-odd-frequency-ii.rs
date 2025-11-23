use std::collections::HashMap;

impl Solution {
    pub fn max_frequency_difference(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut max_diff = i32::min_value();

        for (&num, _) in &freq {
            let mut even_freq = HashMap::new();
            let mut odd_freq = HashMap::new();

            for &n in &nums {
                if n == num {
                    *even_freq.entry(n).or_insert(0) += 1;
                } else {
                    *odd_freq.entry(n).or_insert(0) += 1;
                }
            }

            let even_sum: i32 = even_freq.values().sum();
            let mut odd_vals: Vec<i32> = odd_freq.values().cloned().collect();
            odd_vals.sort();

            let mut odd_sum: i32 = 0;
            if !odd_vals.is_empty() {
                odd_sum = odd_vals.iter().sum();
            }

            max_diff = max_diff.max(even_sum - odd_sum);

        }

        max_diff
    }
}