impl Solution {
    pub fn zero_array_transformation_iii(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut total_operations = 0;
        let mut prev_val = 0;

        for i in 0..n {
            if nums[i] > prev_val {
                total_operations += nums[i] - prev_val;
            }
            prev_val = nums[i];
        }

        total_operations
    }
}