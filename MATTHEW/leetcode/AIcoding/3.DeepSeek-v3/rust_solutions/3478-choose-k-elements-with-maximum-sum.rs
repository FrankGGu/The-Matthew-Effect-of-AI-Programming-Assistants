impl Solution {
    pub fn maximize_sum(nums: Vec<i32>, k: i32) -> i32 {
        let max_num = *nums.iter().max().unwrap();
        max_num * k + k * (k - 1) / 2
    }
}