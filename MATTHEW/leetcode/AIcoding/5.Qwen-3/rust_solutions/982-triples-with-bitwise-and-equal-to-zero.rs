impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_triplets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut map = HashMap::new();

        for i in 0..n {
            for j in i + 1..n {
                let and = nums[i] & nums[j];
                *map.entry(and).or_insert(0) += 1;
            }
        }

        for k in 0..n {
            let num = nums[k];
            for &and in map.keys() {
                if (num & and) == 0 {
                    count += map[&and];
                }
            }
        }

        count
    }
}
}