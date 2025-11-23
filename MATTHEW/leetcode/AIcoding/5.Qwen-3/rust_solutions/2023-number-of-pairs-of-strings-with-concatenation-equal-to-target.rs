impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_pairs(nums: Vec<String>, target: String) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for num in &nums {
            let complement = target.clone().replace(num, "");
            if let Some(&c) = map.get(&complement) {
                count += c;
            }
            *map.entry(num.clone()).or_insert(0) += 1;
        }

        count
    }
}
}