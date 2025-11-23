impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        let remainder = sum % k;
        if remainder == 0 {
            return 0;
        }
        let mut operations = 0;
        let mut current_sum = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            current_sum += nums[right];
            while current_sum % k == remainder {
                current_sum -= nums[left];
                left += 1;
                operations += 1;
            }
        }
        if operations == 0 {
            return -1;
        }
        operations
    }
}