struct Solution;

impl Solution {
    pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = Vec::with_capacity(n);

        for i in 0..n {
            let left = &nums[..i];
            let right = &nums[i+1..];

            let left_unique = left.iter().collect::<std::collections::HashSet<_>>();
            let right_unique = right.iter().collect::<std::collections::HashSet<_>>();

            let left_count = left_unique.len() as i32;
            let right_count = right_unique.len() as i32;

            result.push(left_count - right_count);
        }

        result
    }
}