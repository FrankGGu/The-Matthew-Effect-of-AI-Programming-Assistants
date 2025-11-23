use std::collections::HashSet;

impl Solution {
    pub fn find_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut count = 0;
        let mut pairs = HashSet::new();

        for &num in &nums {
            if seen.contains(&(num - k)) && !pairs.contains(&(num - k, num)) {
                count += 1;
                pairs.insert((num - k, num));
            }
            if seen.contains(&(num + k)) && !pairs.contains(&(num, num + k)) {
                count += 1;
                pairs.insert((num, num + k));
            }
            seen.insert(num);
        }

        count
    }
}