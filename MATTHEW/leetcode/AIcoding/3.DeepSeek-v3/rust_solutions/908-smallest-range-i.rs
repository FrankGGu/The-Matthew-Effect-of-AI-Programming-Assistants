impl Solution {
    pub fn smallest_range_i(nums: Vec<i32>, k: i32) -> i32 {
        let min_val = nums.iter().min().unwrap();
        let max_val = nums.iter().max().unwrap();
        let diff = max_val - min_val - 2 * k;
        if diff < 0 { 0 } else { diff }
    }
}