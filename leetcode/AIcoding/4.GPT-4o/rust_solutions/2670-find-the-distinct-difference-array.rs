pub fn distinct_difference_array(nums: Vec<i32>) -> Vec<i32> {
    use std::collections::HashSet;

    let n = nums.len();
    let mut result = vec![0; n];
    let mut left_set = HashSet::new();
    let mut right_count = HashSet::new();

    for &num in &nums {
        right_count.insert(num);
    }

    for i in 0..n {
        left_set.insert(nums[i]);
        right_count.remove(&nums[i]);
        result[i] = left_set.len() as i32 - right_count.len() as i32;
    }

    result
}