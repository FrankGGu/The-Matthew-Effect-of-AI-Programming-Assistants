use std::collections::HashMap;

impl Solution {
    pub fn length_of_lis(nums: Vec<i32>, k: i32) -> i32 {
        let mut dp = HashMap::new();
        let mut max_length = 0;

        for &num in &nums {
            let mut length = 1;

            for j in (num - k)..num {
                if let Some(&l) = dp.get(&(j as i32)) {
                    length = length.max(l + 1);
                }
            }

            dp.insert(num, length);
            max_length = max_length.max(length);
        }

        max_length
    }
}