impl Solution {
    pub fn min_elements(nums: Vec<i32>, limit: i32, goal: i32) -> i32 {
        let current_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        let goal_i64 = goal as i64;
        let limit_i64 = limit as i64;

        let diff_needed: i64 = goal_i64 - current_sum;

        let abs_diff_needed: i64 = diff_needed.abs();

        if abs_diff_needed == 0 {
            return 0;
        }

        let num_elements: i64 = (abs_diff_needed + limit_i64 - 1) / limit_i64;

        num_elements as i32
    }
}