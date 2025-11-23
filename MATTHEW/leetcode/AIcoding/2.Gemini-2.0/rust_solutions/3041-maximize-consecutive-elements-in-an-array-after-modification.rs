use std::collections::HashMap;

impl Solution {
    pub fn max_consecutive(nums: Vec<i32>) -> i32 {
        let mut map: HashMap<i32, i32> = HashMap::new();
        let mut ans = 0;

        for &num in &nums {
            if map.contains_key(&num) {
                continue;
            }

            let left = if let Some(&val) = map.get(&(num - 1)) {
                val
            } else {
                0
            };

            let right = if let Some(&val) = map.get(&(num + 1)) {
                val
            } else {
                0
            };

            let total = left + right + 1;
            map.insert(num, total);
            ans = ans.max(total);

            map.insert(num - left, total);
            map.insert(num + right, total);
        }

        ans
    }
}