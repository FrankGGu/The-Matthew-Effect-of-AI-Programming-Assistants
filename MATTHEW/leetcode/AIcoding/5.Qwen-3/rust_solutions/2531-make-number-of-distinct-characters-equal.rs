impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_equal_possible(s: String, k: i32) -> bool {
        let n = s.len();
        if k == 0 {
            return true;
        }
        let k = k as usize;
        if k > n {
            return false;
        }

        for i in 0..n - k + 1 {
            let mut freq = HashMap::new();
            for j in i..i + k {
                let c = s.chars().nth(j).unwrap();
                *freq.entry(c).or_insert(0) += 1;
            }
            let distinct = freq.len();
            if distinct == 1 {
                return true;
            }
        }

        false
    }
}
}