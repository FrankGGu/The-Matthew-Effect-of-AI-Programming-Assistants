impl Solution {
    pub fn minimum_difference(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums.clone();
        nums.sort();
        let k = k as usize;
        let mut min_diff = i32::MAX;

        for i in 0..=nums.len() - k {
            min_diff = min_diff.min(nums[i + k - 1] - nums[i]);
        }

        min_diff
    }
}