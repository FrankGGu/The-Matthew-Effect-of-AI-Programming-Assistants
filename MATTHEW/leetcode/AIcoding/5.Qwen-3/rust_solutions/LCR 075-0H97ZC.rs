impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn relative_sort(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        for &num in &arr1 {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for &num in &arr2 {
            if let Some(&freq) = count.get(&num) {
                for _ in 0..freq {
                    result.push(num);
                }
                count.remove(&num);
            }
        }

        let mut remaining: Vec<_> = count.into_iter().flat_map(|(k, v)| vec![k; v]).collect();
        remaining.sort();

        result.extend(remaining);
        result
    }
}
}