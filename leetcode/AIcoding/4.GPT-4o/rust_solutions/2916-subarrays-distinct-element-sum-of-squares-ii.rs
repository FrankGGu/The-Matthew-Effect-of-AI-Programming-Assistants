pub fn sum_of_squares(nums: Vec<i32>) -> i32 {
    use std::collections::HashSet;

    let n = nums.len();
    let mut result = 0;

    for i in 0..n {
        let mut seen = HashSet::new();
        for j in i..n {
            seen.insert(nums[j]);
            if seen.len() > 1 {
                break;
            }
            result += nums[j] * nums[j];
        }
    }

    result
}