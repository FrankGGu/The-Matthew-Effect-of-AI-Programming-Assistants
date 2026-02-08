pub fn min_cost(nums: Vec<i32>) -> i32 {
    let mut counts = std::collections::HashMap::new();
    for &num in &nums {
        *counts.entry(num).or_insert(0) += 1;
    }

    let max_count = *counts.values().max().unwrap();
    (nums.len() as i32) - max_count
}