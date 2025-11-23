use std::collections::HashMap;
use std::cmp::Ord;

pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
    let mut counts = HashMap::new();
    for &num in &nums {
        *counts.entry(num).or_insert(0) += 1;
    }

    let mut buckets: Vec<Vec<i32>> = vec![vec![]; nums.len() + 1];
    for (num, count) in counts {
        buckets[count as usize].push(num);
    }

    let mut result = Vec::new();
    for i in (1..buckets.len()).rev() {
        for &num in &buckets[i] {
            result.push(num);
            if result.len() as i32 == k {
                return result;
            }
        }
    }

    result
}