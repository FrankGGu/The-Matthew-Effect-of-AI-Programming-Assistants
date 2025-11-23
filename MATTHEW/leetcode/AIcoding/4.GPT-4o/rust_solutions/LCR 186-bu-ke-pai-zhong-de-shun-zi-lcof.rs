pub fn check_if_exists(arr: Vec<i32>) -> bool {
    let mut seen = std::collections::HashSet::new();
    for &num in &arr {
        if seen.contains(&(num * 2)) || (num % 2 == 0 && seen.contains(&(num / 2))) {
            return true;
        }
        seen.insert(num);
    }
    false
}