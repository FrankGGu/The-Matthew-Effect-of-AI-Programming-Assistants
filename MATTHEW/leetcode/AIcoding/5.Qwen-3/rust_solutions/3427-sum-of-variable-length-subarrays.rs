impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_of_subarrays(arr: Vec<i32>) -> i64 {
        let n = arr.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + arr[i];
        }

        let mut map = HashMap::new();
        let mut result = 0;

        for i in 0..n {
            let mut current = 0;
            for j in i..n {
                current += arr[j];
                *map.entry(current).or_insert(0) += 1;
            }
        }

        for (key, count) in map {
            result += key as i64 * count as i64;
        }

        result
    }
}
}