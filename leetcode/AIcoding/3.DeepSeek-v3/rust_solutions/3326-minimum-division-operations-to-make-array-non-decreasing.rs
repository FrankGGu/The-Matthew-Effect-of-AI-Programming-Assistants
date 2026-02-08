impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut prev = nums[0];

        for &num in nums.iter().skip(1) {
            if num < prev {
                operations += 1;
            } else {
                prev = num;
            }
        }

        operations
    }
}