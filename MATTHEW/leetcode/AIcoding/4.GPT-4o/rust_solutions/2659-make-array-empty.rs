pub fn min_operations(nums: Vec<i32>) -> i32 {
    let mut count = 0;
    let mut seen = std::collections::HashSet::new();

    for &num in &nums {
        if num != 0 && !seen.contains(&num) {
            seen.insert(num);
            count += 1;
        }
    }

    count
}