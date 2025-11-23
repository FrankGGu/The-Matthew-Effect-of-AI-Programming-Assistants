impl Solution {
    pub fn minimize_array_length(arr: Vec<i32>) -> i32 {
        let mut unique_nums = arr.into_iter().collect::<std::collections::HashSet<_>>();
        unique_nums.len() as i32
    }
}