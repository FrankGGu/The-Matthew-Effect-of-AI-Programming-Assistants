use std::collections::HashMap;

impl Solution {
    pub fn can_arrange(arr: Vec<i32>, k: i32) -> bool {
        let mut freq = HashMap::new();
        for num in arr {
            let rem = ((num % k) + k) % k;
            *freq.entry(rem).or_insert(0) += 1;
        }
        for rem in 0..=k / 2 {
            if rem == 0 {
                if freq.get(&rem).map_or(false, |&count| count % 2 != 0) {
                    return false;
                }
            } else {
                let complement = k - rem;
                if freq.get(&rem).unwrap_or(&0) != freq.get(&complement).unwrap_or(&0) {
                    return false;
                }
            }
        }
        true
    }
}