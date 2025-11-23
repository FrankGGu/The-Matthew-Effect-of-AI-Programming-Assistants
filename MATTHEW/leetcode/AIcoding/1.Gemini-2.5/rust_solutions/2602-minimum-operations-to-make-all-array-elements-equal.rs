impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let median = nums[n / 2];
        let mut operations: i64 = 0;
        for &num in nums.iter() {
            operations += (num - median).abs() as i64;
        }
        operations
    }
}