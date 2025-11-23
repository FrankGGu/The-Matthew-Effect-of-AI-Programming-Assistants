struct Solution;

impl Solution {
    pub fn smallest_subarrays_with_max_bitwise_or(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];

        for i in 0..n {
            let mut current_or = 0;
            for j in i..n {
                current_or |= nums[j];
                result[i] = std::cmp::max(result[i], (j - i + 1) as i32);
            }
        }

        result
    }
}