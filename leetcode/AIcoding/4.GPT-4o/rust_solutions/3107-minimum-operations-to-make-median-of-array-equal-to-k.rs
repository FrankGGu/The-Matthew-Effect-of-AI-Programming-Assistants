impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut ops = 0;
        for &num in &nums {
            ops += (num - k).abs();
        }
        ops
    }
}