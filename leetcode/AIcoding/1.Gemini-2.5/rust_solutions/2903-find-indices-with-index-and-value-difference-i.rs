impl Solution {
    pub fn find_indices(nums: Vec<i32>, index_difference: i32, value_difference: i32) -> Vec<i32> {
        let n = nums.len();
        for i in 0..n {
            for j in 0..n {
                if (i as i32 - j as i32).abs() >= index_difference &&
                   (nums[i] - nums[j]).abs() >= value_difference {
                    return vec![i as i32, j as i32];
                }
            }
        }
        vec![-1, -1]
    }
}