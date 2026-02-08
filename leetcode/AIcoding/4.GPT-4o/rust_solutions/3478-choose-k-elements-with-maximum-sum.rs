impl Solution {
    pub fn max_sum_k_elements(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        nums.iter().rev().take(k as usize).sum()
    }
}