impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let target_score = nums[0] + nums[1];
        let mut operations = 0;

        for i in (0..nums.len()).step_by(2) {
            if i + 1 < nums.len() {
                let current_sum = nums[i] + nums[i + 1];
                if current_sum == target_score {
                    operations += 1;
                } else {
                    break;
                }
            } else {
                break;
            }
        }

        operations
    }
}