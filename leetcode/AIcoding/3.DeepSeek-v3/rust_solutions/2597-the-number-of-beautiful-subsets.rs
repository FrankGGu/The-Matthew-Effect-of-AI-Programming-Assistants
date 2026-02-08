use std::collections::HashMap;

impl Solution {
    pub fn beautiful_subsets(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut nums = nums;
        nums.sort();
        Self::backtrack(&nums, 0, &mut freq, k) - 1
    }

    fn backtrack(nums: &[i32], idx: usize, freq: &mut HashMap<i32, i32>, k: i32) -> i32 {
        if idx == nums.len() {
            return 1;
        }
        let mut res = Self::backtrack(nums, idx + 1, freq, k);
        let num = nums[idx];
        if *freq.get(&(num - k)).unwrap_or(&0) == 0 {
            *freq.entry(num).or_insert(0) += 1;
            res += Self::backtrack(nums, idx + 1, freq, k);
            *freq.get_mut(&num).unwrap() -= 1;
        }
        res
    }
}