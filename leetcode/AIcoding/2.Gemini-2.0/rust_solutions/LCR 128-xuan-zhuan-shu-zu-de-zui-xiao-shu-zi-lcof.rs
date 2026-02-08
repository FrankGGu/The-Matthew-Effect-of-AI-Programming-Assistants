impl Solution {
    pub fn check_if_exist(arr: Vec<i32>) -> bool {
        use std::collections::HashSet;
        let mut seen = HashSet::new();
        for &num in &arr {
            if seen.contains(&(num * 2)) {
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