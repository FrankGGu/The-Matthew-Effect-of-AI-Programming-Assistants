impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_divisible(nums: Vec<i32>, m: i32) -> bool {
        let mut seen = HashSet::new();
        seen.insert(0);
        for num in nums {
            let mut new_seen = HashSet::new();
            for &mod_val in &seen {
                let new_mod = (mod_val * 10 + num) % m;
                new_seen.insert(new_mod);
            }
            seen = new_seen;
        }
        seen.contains(&0)
    }
}
}