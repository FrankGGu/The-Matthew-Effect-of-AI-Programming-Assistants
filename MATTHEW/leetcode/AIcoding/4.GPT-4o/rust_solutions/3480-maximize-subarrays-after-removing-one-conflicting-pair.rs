pub fn maximize_sum(nums: Vec<i32>, remove: Vec<(i32, i32)>) -> i32 {
    let mut idx_map = std::collections::HashMap::new();
    for (a, b) in remove {
        idx_map.insert(a, b);
        idx_map.insert(b, a);
    }

    let mut max_sum = 0;
    let n = nums.len();

    for i in 0..n {
        let mut current_sum = 0;
        let mut used = std::collections::HashSet::new();

        for j in i..n {
            if used.contains(&nums[j]) || idx_map.get(&nums[j]).map_or(false, |&conflict| used.contains(&conflict)) {
                continue;
            }
            used.insert(nums[j]);
            current_sum += nums[j];
        }
        max_sum = max_sum.max(current_sum);
    }

    max_sum
}