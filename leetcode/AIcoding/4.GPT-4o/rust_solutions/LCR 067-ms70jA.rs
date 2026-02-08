pub fn find_maximum_xor(nums: Vec<i32>) -> i32 {
    let mut max_xor = 0;
    let mut prefix_set = std::collections::HashSet::new();

    for i in 31..=0 {
        max_xor <<= 1;
        let candidate = max_xor | 1;
        prefix_set.clear();

        for &num in &nums {
            prefix_set.insert(num >> i);
        }

        for &prefix in &prefix_set {
            if prefix_set.contains(&(candidate ^ prefix)) {
                max_xor = candidate;
                break;
            }
        }
    }

    max_xor
}