impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn has_continuous_subarray_sum(nums: Vec<i32>, k: i32) -> bool {
        let mut prefix_mod = HashMap::new();
        prefix_mod.insert(0, -1);
        let mut mod_sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            mod_sum = (mod_sum + num) % k;
            if let Some(&prev) = prefix_mod.get(&mod_sum) {
                if i as i32 - prev > 1 {
                    return true;
                }
            } else {
                prefix_mod.insert(mod_sum, i as i32);
            }
        }
        false
    }
}
}