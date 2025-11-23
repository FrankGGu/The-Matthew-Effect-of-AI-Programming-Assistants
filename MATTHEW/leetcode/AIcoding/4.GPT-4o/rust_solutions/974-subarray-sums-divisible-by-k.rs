use std::collections::HashMap;

impl Solution {
    pub fn subarrays_div_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        let mut map = HashMap::new();
        map.insert(0, 1);

        for &num in &nums {
            sum += num;
            let mod_sum = ((sum % k) + k) % k;
            count += map.get(&mod_sum).unwrap_or(&0);
            *map.entry(mod_sum).or_insert(0) += 1;
        }

        count
    }
}