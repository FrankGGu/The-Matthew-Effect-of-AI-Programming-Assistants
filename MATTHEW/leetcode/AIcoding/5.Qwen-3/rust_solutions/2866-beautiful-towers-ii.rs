impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn get_number_of_beautiful_subarrays_and_values(arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut prefix_xor = vec![0; n + 1];
        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        let mut result = vec![0; n];
        let mut freq = std::collections::HashMap::new();
        freq.insert(0, 0);

        for i in 1..=n {
            let current = prefix_xor[i];
            let count = *freq.get(&current).unwrap_or(&0);
            result[i - 1] = count as i32;
            *freq.entry(current).or_insert(0) += 1;
        }

        result
    }
}
}