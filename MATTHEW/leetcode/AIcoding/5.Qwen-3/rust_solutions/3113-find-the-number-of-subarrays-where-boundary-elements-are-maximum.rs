impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_subarrays(mut arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut max_indices = HashMap::new();
        let mut result = 0;

        for i in 0..n {
            let current = arr[i];
            let mut max_index = i;
            for j in (i..n).rev() {
                if arr[j] > current {
                    break;
                }
                if arr[j] == current {
                    max_index = j;
                }
            }
            max_indices.insert(i, max_index);
        }

        for i in 0..n {
            let end = *max_indices.get(&i).unwrap();
            let count = end - i + 1;
            result += count;
        }

        result
    }
}
}