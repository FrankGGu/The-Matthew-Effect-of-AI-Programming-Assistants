impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut current = 0;
        for &num in nums.iter() {
            if num > current {
                operations += num - current;
            }
            current = num;
        }
        operations
    }
}