use std::collections::HashMap;

impl Solution {
    pub fn find_matrix(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut freq = HashMap::new();
        let mut max_freq = 0;

        for &num in &nums {
            let count = freq.entry(num).or_insert(0);
            *count += 1;
            max_freq = max_freq.max(*count);
        }

        let mut result = vec![vec![]; max_freq];

        for (num, count) in freq {
            for i in 0..count {
                result[i].push(num);
            }
        }

        result
    }
}