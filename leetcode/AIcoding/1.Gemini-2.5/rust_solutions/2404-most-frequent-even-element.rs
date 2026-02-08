use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();

        for &num in nums.iter() {
            if num % 2 == 0 {
                *counts.entry(num).or_insert(0) += 1;
            }
        }

        let mut max_freq = 0;
        let mut result_num = -1;

        for (&num, &freq) in counts.iter() {
            if freq > max_freq {
                max_freq = freq;
                result_num = num;
            } else if freq == max_freq {
                if num < result_num {
                    result_num = num;
                }
            }
        }

        result_num
    }
}