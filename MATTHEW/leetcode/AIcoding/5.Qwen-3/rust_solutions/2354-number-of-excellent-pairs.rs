impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn excellent_pairs(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut unique_nums = HashSet::new();
        for num in nums.iter() {
            unique_nums.insert(*num);
        }
        let mut nums: Vec<i32> = unique_nums.into_iter().collect();
        nums.sort();
        let mut count = 0;
        let n = nums.len();
        let k = k as usize;
        for i in 0..n {
            for j in i..n {
                if nums[i] + nums[j] >= k as i32 {
                    count += 1;
                }
            }
        }
        count as i32
    }
}
}