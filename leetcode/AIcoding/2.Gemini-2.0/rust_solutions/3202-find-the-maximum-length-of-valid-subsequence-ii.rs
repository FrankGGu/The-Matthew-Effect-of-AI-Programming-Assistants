use std::collections::HashMap;

impl Solution {
    pub fn max_length(nums: Vec<i32>, k: i32) -> i32 {
        let mut dp: HashMap<i32, i32> = HashMap::new();
        let mut ans = 0;

        for &num in &nums {
            let mut max_len = 0;
            for (&key, &len) in &dp {
                if num % key == 0 {
                    max_len = max_len.max(len);
                }
            }

            let new_len = max_len + 1;
            if new_len > *dp.get(&num).unwrap_or(&0) {
                dp.insert(num, new_len);
                ans = ans.max(new_len);
            }

            let mut to_remove: Vec<i32> = Vec::new();
            for (&key, &len) in &dp {
                if num % key == 0 && *dp.get(&num).unwrap_or(&0) >= len {
                    to_remove.push(key);
                }
            }
            for key in to_remove {
                dp.remove(&key);
            }
        }

        ans
    }
}