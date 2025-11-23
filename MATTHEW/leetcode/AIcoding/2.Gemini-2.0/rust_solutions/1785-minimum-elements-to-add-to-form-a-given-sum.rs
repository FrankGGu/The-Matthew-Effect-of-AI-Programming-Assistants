impl Solution {
    pub fn min_elements(nums: Vec<i32>, limit: i32, goal: i32) -> i32 {
        let sum: i64 = nums.iter().map(|&x| x as i64).sum();
        let diff: i64 = (goal as i64) - sum;
        let abs_diff = diff.abs();
        ((abs_diff + (limit as i64) - 1) / (limit as i64)) as i32
    }
}