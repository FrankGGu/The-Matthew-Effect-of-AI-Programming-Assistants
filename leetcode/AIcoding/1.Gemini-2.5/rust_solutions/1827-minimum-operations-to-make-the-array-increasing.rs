impl Solution {
    pub fn min_operations(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut operations = 0;

        for i in 1..n {
            if nums[i] <= nums[i - 1] {
                let required_val = nums[i - 1] + 1;
                operations += required_val - nums[i];
                nums[i] = required_val;
            }
        }

        operations
    }
}