use std::collections::HashSet;

impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i32 {
        let total_distinct: HashSet<_> = nums.iter().collect();
        let k = total_distinct.len();
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            let mut current_distinct = HashSet::new();
            for j in i..n {
                current_distinct.insert(nums[j]);
                if current_distinct.len() == k {
                    count += n - j;
                    break;
                }
            }
        }

        count as i32
    }
}