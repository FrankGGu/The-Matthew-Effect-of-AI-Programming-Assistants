use std::collections::HashSet;

impl Solution {
    pub fn count_distinct(nums: Vec<i32>, k: i32, p: i32) -> i32 {
        let n = nums.len();
        let mut set = HashSet::new();
        for i in 0..n {
            let mut count = 0;
            let mut current = Vec::new();
            for j in i..n {
                if nums[j] % p == 0 {
                    count += 1;
                }
                if count > k {
                    break;
                }
                current.push(nums[j]);
                set.insert(current.clone());
            }
        }
        set.len() as i32
    }
}