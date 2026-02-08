pub fn distribute_repeating_integers(nums: Vec<i32>, k: i32) -> bool {
    let mut count = std::collections::HashMap::new();
    for &num in &nums {
        *count.entry(num).or_insert(0) += 1;
    }

    let max_count = *count.values().max().unwrap();

    max_count <= (nums.len() + k - 1) / k
}