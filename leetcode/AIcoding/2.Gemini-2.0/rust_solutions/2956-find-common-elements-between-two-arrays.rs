use std::collections::HashMap;

impl Solution {
    pub fn common_elements(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut count1: HashMap<i32, i32> = HashMap::new();
        let mut count2: HashMap<i32, i32> = HashMap::new();

        for &num in &arr1 {
            *count1.entry(num).or_insert(0) += 1;
        }

        for &num in &arr2 {
            *count2.entry(num).or_insert(0) += 1;
        }

        let mut result: Vec<i32> = Vec::new();
        for (&num, &freq1) in &count1 {
            if let Some(&freq2) = count2.get(&num) {
                let min_freq = std::cmp::min(freq1, freq2);
                for _ in 0..min_freq {
                    result.push(num);
                }
            }
        }

        result.sort();
        result
    }
}