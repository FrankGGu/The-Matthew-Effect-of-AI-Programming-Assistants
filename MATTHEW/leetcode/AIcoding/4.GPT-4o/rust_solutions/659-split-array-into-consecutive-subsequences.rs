use std::collections::HashMap;

pub fn is_possible(nums: Vec<i32>) -> bool {
    let mut tails = HashMap::new();

    for &num in &nums {
        let prev_count = tails.entry(num - 1).or_insert(0);
        if *prev_count > 0 {
            *prev_count -= 1;
            *tails.entry(num).or_insert(0) += 1;
        } else {
            *tails.entry(num).or_insert(0) += 1;
        }
    }

    for (key, &count) in &tails {
        if count > 0 && tails.get(&(key + 1)).unwrap_or(&0) < &count {
            return false;
        }
    }

    true
}