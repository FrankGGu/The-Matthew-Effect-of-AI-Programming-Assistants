use std::collections::HashSet;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut unique: Vec<i32> = nums.into_iter().collect::<HashSet<_>>().into_iter().collect();
        unique.sort_unstable();
        let m = unique.len();
        let mut res = n as i32;
        let mut j = 0;
        for i in 0..m {
            while j < m && unique[j] < unique[i] + n as i32 {
                j += 1;
            }
            res = res.min((n - (j - i)) as i32;
        }
        res
    }
}