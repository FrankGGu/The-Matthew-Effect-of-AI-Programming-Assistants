impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        for &num in &nums {
            if num < k {
                count += 1;
            }
        }
        count
    }
}