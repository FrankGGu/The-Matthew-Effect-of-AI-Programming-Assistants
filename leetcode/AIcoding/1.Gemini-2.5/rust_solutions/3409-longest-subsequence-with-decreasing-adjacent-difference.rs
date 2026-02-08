use std::collections::HashMap;

impl Solution {
    pub fn longest_subsequence(arr: Vec<i32>, diff: i32) -> i32 {
        let mut dp: HashMap<i32, i32> = HashMap::new();
        let mut max_len = 0;

        for &num in arr.iter() {
            let prev_num_val = num - diff;
            let prev_len = *dp.get(&prev_num_val).unwrap_or(&0);
            let current_len = prev_len + 1;

            dp.insert(num, current_len);
            max_len = max_len.max(current_len);
        }

        max_len
    }
}