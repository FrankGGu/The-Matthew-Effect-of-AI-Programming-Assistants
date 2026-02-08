use std::collections::HashMap;

impl Solution {
    pub fn max_equal_freq(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut freq = HashMap::new();
        let mut max_freq = 0;

        for &num in &nums {
            let current_count = count.entry(num).or_insert(0);
            if *current_count > 0 {
                *freq.entry(*current_count).or_insert(0) -= 1;
            }
            *current_count += 1;
            let new_count = *current_count;
            *freq.entry(new_count).or_insert(0) += 1;
            max_freq = max_freq.max(new_count);
        }

        let mut max_equal_freq = 0;
        for (f, cnt) in &freq {
            let total_count = f * cnt;
            let remaining = nums.len() - total_count;

            if *cnt == 1 {
                if *f == 1 || remaining == 0 {
                    max_equal_freq = max_equal_freq.max(nums.len());
                }
            } else {
                max_equal_freq = max_equal_freq.max(total_count + 1);
            }

            if remaining > 0 {
                max_equal_freq = max_equal_freq.max(total_count);
            }
        }

        max_equal_freq
    }
}