use std::collections::HashMap;

impl Solution {
    pub fn longest_subsequence(arr: Vec<i32>, difference: i32) -> i32 {
        let mut dp: HashMap<i32, i32> = HashMap::new();
        let mut max_len = 0;

        for num in arr {
            let prev_val = num - difference;
            let current_len = *dp.get(&prev_val).unwrap_or(&0) + 1;

            dp.insert(num, current_len);
            max_len = max_len.max(current_len);
        }

        max_len
    }
}