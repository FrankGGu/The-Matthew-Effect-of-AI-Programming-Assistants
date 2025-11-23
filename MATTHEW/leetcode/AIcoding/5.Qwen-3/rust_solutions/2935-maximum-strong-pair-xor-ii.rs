impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let mut mask = 0;

        for i in (0..31).rev() {
            mask |= 1 << i;
            let mut prefixes = HashMap::new();

            for &num in &nums {
                let prefix = num & mask;
                prefixes.insert(prefix, ());
            }

            let mut temp = max_xor | (1 << i);

            for &prefix in prefixes.keys() {
                if prefixes.contains_key(&(prefix ^ temp)) {
                    max_xor = temp;
                    break;
                }
            }
        }

        max_xor
    }
}
}