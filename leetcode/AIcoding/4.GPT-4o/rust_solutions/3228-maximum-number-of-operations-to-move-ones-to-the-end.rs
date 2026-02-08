impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let mut ones_count = 0;
        let mut operations = 0;

        for &num in nums.iter() {
            if num == 1 {
                ones_count += 1;
            } else {
                operations += ones_count;
            }
        }

        operations
    }
}