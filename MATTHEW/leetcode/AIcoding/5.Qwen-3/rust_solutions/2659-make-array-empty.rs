impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_possible_to_make_empty(nums: Vec<i32>) -> bool {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut count = 0;
        let mut prev = -1;
        for (&num, &cnt) in &freq {
            if prev != -1 && num != prev + 1 {
                return false;
            }
            if cnt > 1 {
                count += 1;
            }
            prev = num;
        }

        count == 1
    }
}
}