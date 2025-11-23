impl Solution {
    pub fn smallest_missing(nums: Vec<i32>, prefix_sums: Vec<i32>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        for &num in &nums {
            seen.insert(num);
        }

        let mut missing = 1;
        for &sum in &prefix_sums {
            if sum >= 0 && seen.contains(&missing) {
                while seen.contains(&missing) {
                    missing += 1;
                }
            } else if sum < 0 && seen.contains(&missing) {
                while seen.contains(&missing) {
                    missing += 1;
                }
            }
        }

        missing
    }
}