impl Solution {
    pub fn repeated_n_times(nums: Vec<i32>) -> i32 {
        use std::collections::HashSet;
        let n = nums.len() / 2;
        let mut seen = HashSet::new();
        for &num in &nums {
            if seen.contains(&num) {
                return num;
            }
            seen.insert(num);
        }
        0
    }
}