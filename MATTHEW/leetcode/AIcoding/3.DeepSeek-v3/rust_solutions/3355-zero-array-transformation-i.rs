impl Solution {
    pub fn is_possible(nums: Vec<i32>) -> bool {
        let mut freq = std::collections::HashMap::new();
        let mut need = std::collections::HashMap::new();

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &num in &nums {
            if *freq.get(&num).unwrap() == 0 {
                continue;
            }
            if let Some(count) = need.get_mut(&num) {
                if *count > 0 {
                    *count -= 1;
                    *need.entry(num + 1).or_insert(0) += 1;
                    *freq.entry(num).or_insert(0) -= 1;
                    continue;
                }
            }
            if let Some(&next1) = freq.get(&(num + 1)) {
                if next1 > 0 {
                    if let Some(&next2) = freq.get(&(num + 2)) {
                        if next2 > 0 {
                            *freq.entry(num).or_insert(0) -= 1;
                            *freq.entry(num + 1).or_insert(0) -= 1;
                            *freq.entry(num + 2).or_insert(0) -= 1;
                            *need.entry(num + 3).or_insert(0) += 1;
                            continue;
                        }
                    }
                }
            }
            return false;
        }
        true
    }
}