impl Solution {
    pub fn maximize_sum(nums: Vec<i32>, k: i32) -> i32 {
        let max_val = *nums.iter().max().unwrap();
        let mut total_sum = 0;
        for i in 0..k {
            total_sum += max_val + i;
        }
        total_sum
    }
}