impl Solution {
    pub fn training_plan_iv(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable_by(|a, b| b.cmp(a));
        nums.iter().take(k as usize).sum()
    }
}