pub fn minimal_k_sum(nums: Vec<i32>, k: i32) -> i32 {
    let mut nums_set = std::collections::HashSet::new();
    for &num in &nums {
        if num > 0 {
            nums_set.insert(num);
        }
    }

    let mut sum = 0;
    let mut added = 0;
    let mut current = 1;

    while added < k {
        if !nums_set.contains(&current) {
            sum += current;
            added += 1;
        }
        current += 1;
    }

    sum
}