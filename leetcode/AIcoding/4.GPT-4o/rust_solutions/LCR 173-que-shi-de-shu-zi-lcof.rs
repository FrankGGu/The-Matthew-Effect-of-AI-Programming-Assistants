pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
    let mut counts = std::collections::HashMap::new();
    for &num in &nums {
        if num % 2 == 0 {
            *counts.entry(num).or_insert(0) += 1;
        }
    }
    counts.into_iter()
        .filter(|&(num, _)| num % 2 == 0)
        .max_by_key(|&(num, count)| (count, num))
        .map_or(-1, |(num, _)| num)
}