use std::collections::HashSet;

impl Solution {
    pub fn check_if_exist(arr: Vec<i32>) -> bool {
        let mut seen = HashSet::new();

        for &num in arr.iter() {
            if seen.contains(&(2 * num)) {
                return true;
            }
            if num % 2 == 0 && seen.contains(&(num / 2)) {
                return true;
            }
            seen.insert(num);
        }

        false
    }
}