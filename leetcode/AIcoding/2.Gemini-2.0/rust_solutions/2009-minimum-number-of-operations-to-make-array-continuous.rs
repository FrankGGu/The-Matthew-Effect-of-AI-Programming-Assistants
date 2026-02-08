use std::collections::HashSet;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut unique_nums: Vec<i32> = nums.iter().copied().collect::<HashSet<_>>().into_iter().collect();
        unique_nums.sort();

        let mut ans = n as i32;
        let mut j = 0;

        for i in 0..unique_nums.len() {
            while j < unique_nums.len() && unique_nums[j] < unique_nums[i] + n as i32 {
                j += 1;
            }

            ans = ans.min(n as i32 - (j - i) as i32);
        }

        ans
    }
}