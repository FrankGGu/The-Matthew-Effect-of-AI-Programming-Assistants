use std::collections::HashMap;

impl Solution {
    pub fn number_of_good_partitions(nums: Vec<i32>) -> i32 {
        let mut last_occurrence = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            last_occurrence.insert(num, i);
        }

        let mut res = 1;
        let mut end = 0;
        for (i, &num) in nums.iter().enumerate() {
            end = end.max(*last_occurrence.get(&num).unwrap());
            if i == end {
                res = (res * 2) % 1_000_000_007;
            }
        }

        res
    }
}