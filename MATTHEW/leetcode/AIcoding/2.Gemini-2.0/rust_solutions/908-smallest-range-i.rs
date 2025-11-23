impl Solution {
    pub fn smallest_range_i(nums: Vec<i32>, k: i32) -> i32 {
        let mut min_val = nums[0];
        let mut max_val = nums[0];
        for &num in &nums {
            min_val = min_val.min(num);
            max_val = max_val.max(num);
        }
        let diff = max_val - min_val;
        if diff <= 2 * k {
            0
        } else {
            diff - 2 * k
        }
    }
}