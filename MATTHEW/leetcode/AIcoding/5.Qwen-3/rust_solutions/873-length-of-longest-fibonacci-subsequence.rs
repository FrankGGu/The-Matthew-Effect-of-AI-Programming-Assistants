impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn len_longest_fibonacci_sequence(mut arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = HashMap::new();
        let mut max_len = 0;

        for i in 0..n {
            for j in 0..i {
                let prev = arr[i] - arr[j];
                let key = (arr[j], arr[i]);
                let count = dp.get(&(prev, arr[j])).unwrap_or(&0) + 1;
                dp.insert(key, count);
                max_len = max_len.max(count);
            }
        }

        max_len as i32
    }
}
}