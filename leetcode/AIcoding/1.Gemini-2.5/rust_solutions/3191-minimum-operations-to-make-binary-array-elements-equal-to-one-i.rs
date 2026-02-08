impl Solution {
    pub fn min_operations(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut operations = 0;

        for i in 0..=(n as isize - 3).max(0) as usize {
            if nums[i] == 0 {
                operations += 1;
                nums[i] = 1 - nums[i];
                nums[i + 1] = 1 - nums[i + 1];
                nums[i + 2] = 1 - nums[i + 2];
            }
        }

        for i in 0..n {
            if nums[i] == 0 {
                return -1;
            }
        }

        operations
    }
}