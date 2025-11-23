impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_divide_by_k(arr: Vec<i32>, k: i32) -> bool {
        let mut freq = HashMap::new();
        for &num in &arr {
            let rem = (num % k + k) % k;
            *freq.entry(rem).or_insert(0) += 1;
        }

        if freq.get(&0).unwrap_or(&0) % 2 != 0 {
            return false;
        }

        for i in 1..k {
            let complement = k - i;
            if *freq.get(&i).unwrap_or(&0) != *freq.get(&complement).unwrap_or(&0) {
                return false;
            }
        }

        true
    }
}
}