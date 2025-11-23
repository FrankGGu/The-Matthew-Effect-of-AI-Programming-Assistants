impl Solution {
    pub fn maximum_difference(nums: Vec<i32>) -> i32 {
        let mut max_diff = -1;
        let mut min_value = nums[0];

        for &num in &nums[1..] {
            if num > min_value {
                max_diff = max_diff.max(num - min_value);
            } else {
                min_value = num;
            }
        }

        max_diff
    }
}