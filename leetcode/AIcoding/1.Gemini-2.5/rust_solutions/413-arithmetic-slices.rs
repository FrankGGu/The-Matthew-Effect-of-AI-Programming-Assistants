impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut total_slices = 0;
        let mut current_dp_value = 0;
        let mut prev_diff = nums[1] - nums[0];

        for i in 2..n {
            let new_diff = nums[i] - nums[i - 1];
            if new_diff == prev_diff {
                current_dp_value += 1;
            } else {
                current_dp_value = 0;
            }
            total_slices += current_dp_value;
            prev_diff = new_diff;
        }

        total_slices
    }
}