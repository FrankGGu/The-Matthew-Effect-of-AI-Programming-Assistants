impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_subarray_in_infinite(arr: Vec<i32>, target: i32) -> i32 {
        let n = arr.len();
        let mut map = HashMap::new();
        let mut prefix = 0;
        let mut min_len = i32::MAX;

        for i in 0..n {
            prefix += arr[i];
            if prefix == target {
                min_len = (i + 1).try_into().unwrap();
            }
            if let Some(&prev) = map.get(&(prefix - target)) {
                min_len = min_len.min((i - prev).try_into().unwrap());
            }
            map.insert(prefix, i);
        }

        for i in 0..n {
            prefix += arr[i];
            if prefix == target {
                min_len = min_len.min((i + n).try_into().unwrap());
            }
            if let Some(&prev) = map.get(&(prefix - target)) {
                min_len = min_len.min((i + n - prev).try_into().unwrap());
            }
        }

        if min_len == i32::MAX {
            -1
        } else {
            min_len
        }
    }
}

pub struct Solution;
}