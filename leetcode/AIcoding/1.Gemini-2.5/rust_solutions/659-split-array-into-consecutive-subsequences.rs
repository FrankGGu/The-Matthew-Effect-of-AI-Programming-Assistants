use std::collections::HashMap;

impl Solution {
    pub fn is_possible(nums: Vec<i32>) -> bool {
        let mut freq: HashMap<i32, i32> = HashMap::new();
        let mut ends_at: HashMap<i32, i32> = HashMap::new();

        for &num in nums.iter() {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &num in nums.iter() {
            let current_num_freq = *freq.get(&num).unwrap_or(&0);
            if current_num_freq == 0 {
                continue;
            }

            // Try to extend an existing subsequence
            let ends_at_prev_count = *ends_at.get(&(num - 1)).unwrap_or(&0);
            if ends_at_prev_count > 0 {
                *ends_at.get_mut(&(num - 1)).unwrap() -= 1;
                *ends_at.entry(num).or_insert(0) += 1;
                *freq.get_mut(&num).unwrap() -= 1;
            } else {
                // Try to start a new subsequence of length 3
                let freq_p1 = *freq.get(&(num + 1)).unwrap_or(&0);
                let freq_p2 = *freq.get(&(num + 2)).unwrap_or(&0);

                if freq_p1 > 0 && freq_p2 > 0 {
                    *freq.get_mut(&num).unwrap() -= 1;
                    *freq.get_mut(&(num + 1)).unwrap() -= 1;
                    *freq.get_mut(&(num + 2)).unwrap() -= 1;
                    *ends_at.entry(num + 2).or_insert(0) += 1;
                } else {
                    // Cannot extend an existing subsequence and cannot start a new one
                    return false;
                }
            }
        }

        true
    }
}