impl Solution {
    pub fn repeated_n_times(nums: Vec<i32>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        for &num in &nums {
            if seen.contains(&num) {
                return num;
            }
            seen.insert(num);
        }
        0
    }
}