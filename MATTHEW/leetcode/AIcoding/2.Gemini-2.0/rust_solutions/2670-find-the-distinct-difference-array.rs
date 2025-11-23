impl Solution {
    pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        for i in 0..n {
            let prefix = nums[0..=i].to_vec();
            let suffix = nums[i+1..].to_vec();
            let distinct_prefix = prefix.into_iter().collect::<std::collections::HashSet<_>>().len() as i32;
            let distinct_suffix = suffix.into_iter().collect::<std::collections::HashSet<_>>().len() as i32;
            result[i] = distinct_prefix - distinct_suffix;
        }
        result
    }
}