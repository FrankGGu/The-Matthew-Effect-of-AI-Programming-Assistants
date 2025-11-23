impl Solution {
    pub fn maximize_sum(nums: Vec<i32>, k: i32) -> i32 {
        let max_val = *nums.iter().max().unwrap();
        max_val * k + (k * (k - 1)) / 2
    }
}