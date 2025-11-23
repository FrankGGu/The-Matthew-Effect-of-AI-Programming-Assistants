impl Solution {
    pub fn longest_subsequence_repeated_k_times(arr: Vec<i32>, k: i32) -> Vec<i32> {
        use std::collections::HashMap;

        let mut count = HashMap::new();
        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for (&num, &c) in count.iter() {
            if c >= k {
                result.push(num);
            }
        }

        result.sort();
        result
    }
}