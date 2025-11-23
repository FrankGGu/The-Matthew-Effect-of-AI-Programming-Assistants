use std::collections::HashMap;

impl Solution {
    pub fn count_complete_day_pairs(hours: Vec<i32>) -> i64 {
        let mut mod_map = HashMap::new();
        let mut count = 0i64;

        for hour in hours {
            let mod_val = hour % 24;
            let complement = (24 - mod_val) % 24;
            count += *mod_map.get(&complement).unwrap_or(&0);
            *mod_map.entry(mod_val).or_insert(0) += 1;
        }

        count
    }
}