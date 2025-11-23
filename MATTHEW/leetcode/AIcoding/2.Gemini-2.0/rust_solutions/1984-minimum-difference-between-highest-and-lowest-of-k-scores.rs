impl Solution {
    pub fn minimum_difference(nums: Vec<i32>, k: i32) -> i32 {
        if k == 1 {
            return 0;
        }
        let mut nums = nums;
        nums.sort();
        let mut min_diff = i32::MAX;
        for i in 0..=nums.len() - k as usize {
            let diff = nums[i + k as usize - 1] - nums[i];
            min_diff = min_diff.min(diff);
        }
        min_diff
    }
}