impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_of_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut count = 0;
        let mut map = HashMap::new();
        let mut prefix = 0;
        map.insert(0, 1);

        for i in 0..n {
            prefix += if nums[i] % 2 == 0 { 1 } else { -1 };
            let target = prefix - k;
            count += *map.get(&target).unwrap_or(&0);
            *map.entry(prefix).or_insert(0) += 1;
        }

        count
    }
}
}