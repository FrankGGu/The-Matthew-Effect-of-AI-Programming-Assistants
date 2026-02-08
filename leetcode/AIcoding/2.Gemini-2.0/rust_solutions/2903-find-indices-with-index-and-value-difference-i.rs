impl Solution {
    pub fn find_indices(nums: Vec<i32>, index_difference: i32, value_difference: i32) -> Vec<i32> {
        for i in 0..nums.len() {
            for j in 0..nums.len() {
                if (i as i32 - j as i32).abs() >= index_difference && (nums[i] - nums[j]).abs() >= value_difference {
                    return vec![i as i32, j as i32];
                }
            }
        }
        return vec![-1, -1];
    }
}