use std::collections::HashMap;

impl Solution {
    pub fn find_permutation_difference(s: String, t: String) -> i32 {
        let mut s_map = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            s_map.insert(c, i);
        }

        let mut diff = 0;
        for (i, c) in t.chars().enumerate() {
            diff += (i as i32 - *s_map.get(&c).unwrap() as i32).abs();
        }

        diff
    }
}