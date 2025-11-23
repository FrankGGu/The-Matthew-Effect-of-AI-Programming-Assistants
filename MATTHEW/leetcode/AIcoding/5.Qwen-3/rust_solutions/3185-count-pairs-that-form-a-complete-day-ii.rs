impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_complete_day_pairs(arr: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for num in arr {
            let remainder = num % k;
            let complement = (k - remainder) % k;
            count += *map.get(&complement).unwrap_or(&0);
            *map.entry(remainder).or_insert(0) += 1;
        }

        count
    }
}
}