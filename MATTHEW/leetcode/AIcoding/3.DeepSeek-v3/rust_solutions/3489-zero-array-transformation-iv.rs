impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut nums = nums;
        let n = nums.len();

        loop {
            let mut all_zero = true;
            for &num in &nums {
                if num != 0 {
                    all_zero = false;
                    break;
                }
            }
            if all_zero {
                break;
            }

            let mut min_non_zero = i32::MAX;
            for &num in &nums {
                if num != 0 && num < min_non_zero {
                    min_non_zero = num;
                }
            }

            for i in 0..n {
                if nums[i] != 0 {
                    nums[i] -= min_non_zero;
                }
            }

            operations += min_non_zero;
        }

        operations
    }
}