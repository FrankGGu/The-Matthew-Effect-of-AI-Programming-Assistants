use std::collections::HashMap;

impl Solution {
    pub fn intersection(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut count = HashMap::new();
        let n = nums.len();

        for arr in nums {
            for num in arr {
                *count.entry(num).or_insert(0) += 1;
            }
        }

        let mut result: Vec<i32> = count
            .into_iter()
            .filter(|&(_, v)| v == n)
            .map(|(k, _)| k)
            .collect();

        result.sort();
        result
    }
}