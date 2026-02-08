use std::collections::HashMap;

impl Solution {
    pub fn subarrays_div_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut prefix_mod = 0;
        let mut result = 0;
        let mut mod_map = HashMap::new();
        mod_map.insert(0, 1);

        for num in nums {
            prefix_mod = (prefix_mod + num % k + k) % k;
            result += *mod_map.get(&prefix_mod).unwrap_or(&0);
            *mod_map.entry(prefix_mod).or_insert(0) += 1;
        }

        result
    }
}