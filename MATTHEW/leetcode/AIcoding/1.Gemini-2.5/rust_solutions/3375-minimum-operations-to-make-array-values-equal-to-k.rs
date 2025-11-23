impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut operations = 0;
        for num in nums {
            operations += (num - k).abs();
        }
        operations
    }
}