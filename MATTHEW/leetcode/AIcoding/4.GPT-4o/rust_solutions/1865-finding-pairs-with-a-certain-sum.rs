pub fn find_pairs(nums: Vec<i32>, k: i32) -> i32 {
    use std::collections::HashMap;

    let mut count = 0;
    let mut num_map = HashMap::new();

    for &num in &nums {
        *num_map.entry(num).or_insert(0) += 1;
    }

    for &num in num_map.keys() {
        if k > 0 && num_map.contains_key(&(num + k)) {
            count += 1;
        } else if k == 0 && num_map[&num] > 1 {
            count += 1;
        }
    }

    count
}