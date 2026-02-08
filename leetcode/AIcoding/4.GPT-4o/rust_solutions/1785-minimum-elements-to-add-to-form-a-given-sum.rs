impl Solution {
    pub fn min_elements(nums: Vec<i32>, limit: i32, goal: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        let diff = goal - sum;

        if diff == 0 {
            return 0;
        }

        let abs_diff = diff.abs();
        (abs_diff + limit - 1) / limit
    }
}