impl Solution {
    pub fn maximum_difference(nums: Vec<i32>) -> i32 {
        let mut max_diff = -1;
        let mut min_val = nums[0];

        for j in 1..nums.len() {
            if nums[j] > min_val {
                max_diff = max_diff.max(nums[j] - min_val);
            } else {
                min_val = nums[j];
            }
        }

        max_diff
    }
}