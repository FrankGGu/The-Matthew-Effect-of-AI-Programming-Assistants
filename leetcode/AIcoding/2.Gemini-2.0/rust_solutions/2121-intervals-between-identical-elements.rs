use std::collections::HashMap;

impl Solution {
    pub fn get_distances(arr: Vec<i32>) -> Vec<i64> {
        let mut indices: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            indices.entry(num).or_insert(Vec::new()).push(i);
        }

        let mut result = vec![0; arr.len()];
        for &num in arr.iter().collect::<std::collections::HashSet<_>>().iter() {
            if let Some(idx) = indices.get(num) {
                let n = idx.len();
                let mut prefix_sum: Vec<i64> = vec![0; n + 1];
                for i in 0..n {
                    prefix_sum[i + 1] = prefix_sum[i] + idx[i] as i64;
                }

                for i in 0..n {
                    let left_sum = (i as i64 * idx[i] as i64) - prefix_sum[i] as i64;
                    let right_sum = (prefix_sum[n] - prefix_sum[i + 1]) as i64 - ((n - i - 1) as i64 * idx[i] as i64);
                    result[idx[i]] = left_sum + right_sum;
                }
            }
        }

        result
    }
}