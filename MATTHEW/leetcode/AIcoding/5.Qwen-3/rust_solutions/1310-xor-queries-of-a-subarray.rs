impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sub_xor_queries(arr: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = arr.len();
        let mut prefix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }

        let mut result = Vec::new();

        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            result.push(prefix[r + 1] ^ prefix[l]);
        }

        result
    }
}
}