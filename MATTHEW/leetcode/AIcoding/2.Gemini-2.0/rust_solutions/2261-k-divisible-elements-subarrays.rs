use std::collections::HashSet;

impl Solution {
    pub fn k_divisible_elements(nums: Vec<i32>, k: i32, p: i32) -> i32 {
        let n = nums.len();
        let mut set = HashSet::new();
        for i in 0..n {
            let mut count = 0;
            let mut sub = Vec::new();
            for j in i..n {
                sub.push(nums[j]);
                if nums[j] % p == 0 {
                    count += 1;
                }
                if count > k {
                    break;
                }
                set.insert(sub.clone());
            }
        }
        set.len() as i32
    }
}