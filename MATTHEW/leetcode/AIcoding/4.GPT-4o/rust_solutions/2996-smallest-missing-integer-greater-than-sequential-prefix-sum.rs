impl Solution {
    pub fn smallest_missing_integer(nums: Vec<i32>) -> i32 {
        let mut prefix_sum = 0;
        let mut seen = std::collections::HashSet::new();
        for &num in &nums {
            prefix_sum += num;
            seen.insert(prefix_sum);
        }
        let mut missing = 1;
        while seen.contains(&missing) {
            missing += 1;
        }
        missing
    }
}