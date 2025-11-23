struct Solution;

impl Solution {
    pub fn make_k_subarray_equal(arr: Vec<i32>, k: i32) -> bool {
        let k = k as usize;
        let n = arr.len();
        let mut freq = std::collections::HashMap::new();

        for i in 0..n {
            let idx = i % k;
            *freq.entry(idx).or_insert(0) += 1;
        }

        let max_freq = freq.values().copied().max().unwrap();
        let min_freq = freq.values().copied().min().unwrap();

        max_freq - min_freq <= 1
    }
}