impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_subseqs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut count = 0;
        for i in 0..n {
            let mut mid_freq = HashMap::new();
            let mut max_freq = 0;
            let mut mode = 0;
            for j in i..n {
                let num = nums[j];
                *mid_freq.entry(num).or_insert(0) += 1;
                if mid_freq[&num] > max_freq {
                    max_freq = mid_freq[&num];
                    mode = num;
                } else if mid_freq[&num] == max_freq && num < mode {
                    mode = num;
                }

                if freq[&mode] == max_freq {
                    count += 1;
                }
            }
        }

        count
    }
}
}