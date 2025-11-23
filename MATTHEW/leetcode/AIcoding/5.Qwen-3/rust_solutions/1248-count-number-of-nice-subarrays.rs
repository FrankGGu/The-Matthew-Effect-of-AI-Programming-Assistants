impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_count = HashMap::new();
        prefix_count.insert(0, 1);
        let mut even_count = 0;

        for num in nums {
            if num % 2 == 0 {
                even_count += 1;
            }
            *prefix_count.entry(even_count).or_insert(0) += 1;
            count += *prefix_count.get(&(even_count - k)).unwrap_or(&0);
        }

        count
    }
}
}