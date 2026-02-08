impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();

        for &num in &nums {
            if num <= k {
                seen.insert(num);
            }
        }

        for i in 1..=k {
            if !seen.contains(&i) {
                count += 1;
            }
        }

        count
    }
}