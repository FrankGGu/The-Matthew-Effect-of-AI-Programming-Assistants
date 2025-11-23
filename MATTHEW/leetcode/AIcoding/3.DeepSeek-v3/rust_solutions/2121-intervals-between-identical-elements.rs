use std::collections::HashMap;

impl Solution {
    pub fn get_distances(arr: Vec<i32>) -> Vec<i64> {
        let mut value_indices = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            value_indices.entry(num).or_insert(vec![]).push(i as i64);
        }

        let mut res = vec![0; arr.len()];
        for indices in value_indices.values() {
            let n = indices.len();
            if n == 1 {
                continue;
            }
            let mut prefix = vec![0; n];
            let mut suffix = vec![0; n];
            for i in 1..n {
                prefix[i] = prefix[i - 1] + i as i64 * (indices[i] - indices[i - 1]);
            }
            for i in (0..n - 1).rev() {
                suffix[i] = suffix[i + 1] + (n - 1 - i) as i64 * (indices[i + 1] - indices[i]);
            }
            for i in 0..n {
                res[indices[i] as usize] = (prefix[i] + suffix[i]) as i64;
            }
        }
        res
    }
}