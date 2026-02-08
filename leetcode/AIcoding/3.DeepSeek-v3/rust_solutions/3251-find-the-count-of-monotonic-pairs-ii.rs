impl Solution {
    pub fn count_monotonic_pairs(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut left = 0;
        for right in 1..nums.len() {
            if nums[right] < nums[right - 1] {
                left = right;
            }
            count += (right - left) as i64;
        }
        count
    }
}